import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
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

Future<List<SingleChildWidget>> init(
    {FlutterSecureStorage? secureStorage,
    Httpp? httpp,
    required TikiLogin login}) async {
  Logger log = Logger('provide.init');

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
    String dbPath = await getDatabasesPath() + '/tiki_app_${keys.address}.db';
    Database database = await openDatabase(dbPath, password: keys.data.encode());

    TikiKv tikiKv = await TikiKv(database: database).init();
    login.onLogout('TikiKv', () async => await tikiKv.deleteAll());

    TikiDecision decision = await TikiDecision(tikiKv: tikiKv).init();

    TikiChainService chainService = await TikiChainService(keys).open(
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
        accessToken: () => login.token?.bearer);

    TikiUserAccount userAccount = TikiUserAccount(
        httpp: httpp,
        database: database,
        logout: () => login.logout(),
        refresh: login.refresh,
        combinedKeys: keys.address +
            '.' +
            keys.data.encode() +
            '.' +
            keys.sign.privateKey.encode(),
        accessToken: () => login.token?.bearer);

    TikiMoney money = TikiMoney(
        httpp: httpp, referalCount: int.tryParse(userAccount.referCount) ?? 0);

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
