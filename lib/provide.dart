/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:tiki_data/tiki_data.dart';
import 'package:tiki_decision/tiki_decision.dart';
import 'package:tiki_kv/tiki_kv.dart';
import 'package:tiki_localgraph/tiki_localgraph.dart';
import 'package:tiki_login/tiki_login.dart';
import 'package:tiki_money/tiki_money.dart';
import 'package:tiki_spam_cards/tiki_spam_cards.dart';
import 'package:tiki_user_account/tiki_user_account.dart';
import 'package:tiki_wallet/tiki_wallet.dart';

import 'src/config/config_amplitude.dart';
import 'src/home/home_model_overlay.dart';
import 'src/home/home_service.dart';

Future<List<SingleChildWidget>> init(HomeService homeService,
    {FlutterSecureStorage? secureStorage,
    Httpp? httpp,
    required TikiLogin login}) async {
  Logger log = Logger('provide.init');

  TikiKeysService tikiKeysService =
      TikiKeysService(secureStorage: secureStorage);

  FlowModelUser? user = login.user;
  TikiKeysModel? keys = user?.address != null ? await tikiKeysService.get(user!.address!) : null;

  if (user == null || user.address == null || keys == null) {
    log.severe('Attempting to open home page without a valid user');
    await login.logout();
    return [];
  } else {
    String dbFilename =
        'app-${base64Decode(user.address!).map((e) => e.toRadixString(16).padLeft(2, '0')).join()}.db';
    String dbPath = '${await getDatabasesPath()}/$dbFilename';
    Database database =
        await openDatabase(dbPath, password: keys.data.encode());
    await _truncateLastPageAndLastRunRepos(database);
    TikiKv tikiKv = await TikiKv(database: database).init();

    TikiDecision decision = await TikiDecision(tikiKv: tikiKv).init();
    homeService.addOverlay(HomeModelOverlay(1, decision.overlay));

    TikiChainService chainService = await TikiChainService(keys).open(
        amplitude: ConfigAmplitude.instance,
        database: database,
        kv: tikiKv,
        accessToken: () => login.token?.bearer,
        httpp: httpp,
        refresh: login.refresh);

    TikiLocalGraph localGraph = await TikiLocalGraph(chainService).open(
        database,
        httpp: httpp,
        refresh: login.refresh,
        accessToken: () => login.token?.bearer);

    TikiSpamCards spamCards = TikiSpamCards(decision);

    TikiData data = await TikiData().init(
        database: database,
        spamCards: spamCards,
        decision: decision,
        httpp: httpp,
        localGraph: localGraph,
        refresh: login.refresh,
        amplitude: ConfigAmplitude.instance,
        accessToken: () => login.token?.bearer);

    TikiUserAccount userAccount = TikiUserAccount(
        httpp: httpp,
        database: database,
        logout: () => login.logout(),
        refresh: login.refresh,
        combinedKeys:
            '${keys.address}.${keys.data.encode()}.${keys.sign.privateKey.encode()}',
        accessToken: () => login.token?.bearer);

    TikiMoney money = TikiMoney(
        localGraph: localGraph,
        chainService: chainService,
        referralCount: int.tryParse(userAccount.referCount) ?? 0);

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('tiki_first_run', false);

    return [
      Provider<TikiKeysService>.value(value: tikiKeysService),
      Provider<TikiLogin>.value(value: login),
      Provider<TikiUserAccount>.value(value: userAccount),
      Provider<TikiDecision>.value(value: decision),
      Provider<TikiData>.value(value: data),
      Provider<TikiMoney>.value(value: money)
    ];
  }
}

Future<void> checkFirstRun(FlutterSecureStorage secureStorage) async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('tiki_first_run') ?? true) {
    await secureStorage.deleteAll();
    prefs.setBool('tiki_first_run', false);
  } else {
    prefs.setString('secureStorage_clear', '0.4.4');
  }
}


Future<void> _truncateLastPageAndLastRunRepos(Database database) async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getString('reindexed_inbox_version') != "0.4.4") {
      await database.rawQuery('DROP TABLE IF EXISTS cmd_mgr_last_run;');
      await database.rawQuery('DROP TABLE IF EXISTS fetch_inbox_part;');
      await database.rawQuery('DROP TABLE IF EXISTS fetch_inbox_page;');
      await prefs.setString('reindexed_inbox_version', '0.4.4');
  }
}
