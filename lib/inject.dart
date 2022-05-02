import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:tiki_data/tiki_data.dart';
import 'package:tiki_decision/tiki_decision.dart';
import 'package:tiki_kv/tiki_kv.dart';
import 'package:tiki_login/tiki_login.dart';
import 'package:tiki_spam_cards/tiki_spam_cards.dart';
import 'package:tiki_user_account/tiki_user_account.dart';
import 'package:tiki_wallet/tiki_wallet.dart';

import 'src/slices/api_short_code/api_short_code_service.dart';
import 'src/utils/database.dart' as db;

Future<List<SingleChildWidget>> provide(
    {FlutterSecureStorage? secureStorage,
    Httpp? httpp,
    required TikiLogin login}) async {
  Logger log = Logger('HomeScreenService.provide');

  TikiKeysService tikiKeysService =
      TikiKeysService(secureStorage: secureStorage);

  FlowModelUser? user = login.user;

  TikiKeysModel? keys =
      user?.address != null ? await tikiKeysService.get(user!.address!) : null;
  if (user == null || user.address == null || keys == null) {
    log.severe('Attempting to open home page without a valid user');
    await login.logout();
    return [];
  } else {
    Database database = await db.open(keys.data.encode());

    TikiKv tikiKv = TikiKv(database: database);
    login.onLogout('TikiKv', () async => await tikiKv.deleteAll());

    // TODO get from data lib
    // login.onLogout(
    //     'ApiAuthService', () async => await apiAuthService.signOutAll());

    // bool isConnected = await apiAuthService.getAccount()) != null

    var isConnected = false;
    TikiDecision decision = TikiDecision(
        tikiKv: tikiKv,
        isConnected: isConnected
    );

    TikiSpamCards spamCards = TikiSpamCards(decision: decision);
    ApiShortCodeService apiShortCodeService = ApiShortCodeService();
    String referCode = await _getReferCode(login, apiShortCodeService);
    TikiUserAccount userAccount = TikiUserAccount(
        logout: () => login.logout(),
        referalCode: referCode,
        combinedKeys: keys.address +
            '.' +
            keys.data.encode() +
            '.' +
            keys.sign.privateKey.encode());

    TikiData tikiData = TikiData();
    await tikiData.init(
        database: database,
        spamCards: spamCards,
        decision: decision);

    return [
      Provider<ApiShortCodeService>.value(value:apiShortCodeService),
      Provider<TikiKeysService>.value(value: tikiKeysService),
      Provider<TikiLogin>.value(value: login),
      Provider<TikiDecision>.value(value: decision),
      Provider<TikiUserAccount>.value(value: userAccount),
      Provider<TikiData>.value(value: tikiData),
    ];
  }
}

Future<String> _getReferCode(
    TikiLogin login, ApiShortCodeService apiShortCodeService) async {
  String? code;
  await apiShortCodeService.get(
      accessToken: login.token!.bearer!,
      address: login.user!.address!,
      onSuccess: (rsp) => code = rsp.code!);
  return code ?? '';
}
