import 'package:decision_sdk/decision.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';
import 'package:login/login.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:spam_cards/spam_cards.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:tiki_kv/tiki_kv.dart';
import 'package:user_account/user_account.dart';
import 'package:wallet/wallet.dart';

import 'src/slices/api_company/api_company_service.dart';
import 'src/slices/api_email_msg/api_email_msg_service.dart';
import 'src/slices/api_email_sender/api_email_sender_service.dart';
import 'src/slices/api_knowledge/api_knowledge_service.dart';
import 'src/slices/api_oauth/api_oauth_service.dart';
import 'src/slices/api_short_code/api_short_code_service.dart';
import 'src/slices/api_signup/api_signup_service.dart';
import 'src/slices/data_fetch/data_fetch_service.dart';
import 'src/slices/data_push/data_push_service.dart';
import 'src/utils/database.dart' as db;

Future<List<SingleChildWidget>> provide(
    {FlutterSecureStorage? secureStorage,
    Httpp? httpp,
    required Login login}) async {
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
    login.onLogout('TikiKv', () async => await tikiKv.deleteAllData());

    ApiKnowledgeService apiKnowledgeService =
        ApiKnowledgeService(httpp: httpp, refresh: login.refresh);
    DataPushService dataPushService = DataPushService(
        apiKnowledgeService: apiKnowledgeService,
        database: database,
        login: login);
    ApiEmailSenderService apiEmailSenderService =
        ApiEmailSenderService(database: database);
    ApiEmailMsgService apiEmailMsgService =
        ApiEmailMsgService(database: database);
    ApiCompanyService apiCompanyService = ApiCompanyService(
        database: database,
        login: login,
        apiKnowledgeService: apiKnowledgeService);
    ApiOAuthService apiAuthService =
        ApiOAuthService(httpp: httpp ?? Httpp(), database: database);
    login.onLogout(
        'ApiAuthService', () async => await apiAuthService.signOutAll());

    ApiShortCodeService apiShortCodeService =
        ApiShortCodeService(httpp: httpp, refresh: login.refresh);

    DecisionSdk decisionSdk = DecisionSdk(
        tikiKv: tikiKv,
        isConnected: (await apiAuthService.getAccount()) != null);

    SpamCards spamCards = SpamCards(decisionSdk: decisionSdk);

    DataFetchService dataFetchService = DataFetchService(
        apiAuthService: apiAuthService,
        tikiKv: tikiKv,
        apiCompanyService: apiCompanyService,
        apiEmailSenderService: apiEmailSenderService,
        apiEmailMsgService: apiEmailMsgService,
        apiKnowledgeService: apiKnowledgeService,
        dataPushService: dataPushService,
        database: database);

    UserAccount userAccount = UserAccount(
        logout: () => login.logout(),
        referalCode: await _getReferCode(login, apiShortCodeService),
        combinedKeys: keys.address +
            '.' +
            keys.data.encode() +
            '.' +
            keys.sign.privateKey.encode()
    );

    return [
      Provider<ApiCompanyService>.value(value: apiCompanyService),
      Provider<ApiEmailSenderService>.value(value: apiEmailSenderService),
      Provider<ApiEmailMsgService>.value(value: apiEmailMsgService),
      Provider<TikiKeysService>.value(value: tikiKeysService),
      Provider<ApiOAuthService>.value(value: apiAuthService),
      Provider<ApiKnowledgeService>.value(value: apiKnowledgeService),
      Provider<DataPushService>.value(value: dataPushService),
      ChangeNotifierProvider<DataFetchService>.value(value: dataFetchService),
      Provider<Login>.value(value: login),
      Provider<ApiSignupService>.value(value: apiSignupService),
      Provider<DecisionSdk>.value(value: decisionSdk),
      Provider<UserAccount>.value(value: userAccount),
      Provider<SpamCards>.value(value: spamCards),
      Provider<ApiShortCodeService>.value(value: apiShortCodeService)
    ];
  }
}

Future<String> _getReferCode(Login login, ApiShortCodeService apiShortCodeService) async{
  String? code;
  await apiShortCodeService.get(
      accessToken: login.token!.bearer!,
      address: login.user!.address!,
      onSuccess: (rsp) => code = rsp.code!);
  return code ?? '';
}
