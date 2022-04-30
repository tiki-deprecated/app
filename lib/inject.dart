import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:tiki_decision/tiki_decision.dart';
import 'package:tiki_kv/tiki_kv.dart';
import 'package:tiki_login/tiki_login.dart';
import 'package:tiki_spam_cards/tiki_spam_cards.dart';
import 'package:tiki_user_account/tiki_user_account.dart';
import 'package:tiki_wallet/tiki_wallet.dart';

import 'src/slices/api_oauth/api_oauth_service.dart';
import 'src/slices/api_short_code/api_short_code_service.dart';
import 'src/slices/api_signup/api_signup_service.dart';
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
    ApiSignupService apiSignupService = ApiSignupService();

    Database database = await db.open(keys.data.encode());

    TikiKv tikiKv = TikiKv(database: database);
    login.onLogout('TikiKv', () async => await tikiKv.deleteAll());

    ApiOAuthService apiAuthService =
        ApiOAuthService(httpp: httpp ?? Httpp(), database: database);
    login.onLogout(
        'ApiAuthService', () async => await apiAuthService.signOutAll());

    ApiShortCodeService apiShortCodeService =
        ApiShortCodeService(httpp: httpp, refresh: login.refresh);

    TikiDecision decision = TikiDecision(
        tikiKv: tikiKv,
        isConnected: (await apiAuthService.getAccount()) != null);

    TikiSpamCards spamCards = TikiSpamCards(decision: decision);

    TikiUserAccount userAccount = TikiUserAccount(
        logout: () => login.logout(),
        referalCode: await _getReferCode(login, apiShortCodeService),
        combinedKeys: keys.address +
            '.' +
            keys.data.encode() +
            '.' +
            keys.sign.privateKey.encode());

    return [
      Provider<TikiKeysService>.value(value: tikiKeysService),
      Provider<ApiOAuthService>.value(value: apiAuthService),
      Provider<TikiLogin>.value(value: login),
      Provider<ApiSignupService>.value(value: apiSignupService),
      Provider<TikiDecision>.value(value: decision),
      Provider<TikiUserAccount>.value(value: userAccount),
      Provider<TikiSpamCards>.value(value: spamCards),
      Provider<ApiShortCodeService>.value(value: apiShortCodeService)
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
