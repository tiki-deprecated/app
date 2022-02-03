import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';
import 'package:login/login.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:wallet/wallet.dart';

import 'app.dart';
import 'src/config/config_amplitude.dart';
import 'src/config/config_color.dart';
import 'src/config/config_font.dart';
import 'src/config/config_log.dart';
import 'src/config/config_sentry.dart';
import 'src/slices/api_app_data/api_app_data_service.dart';
import 'src/slices/api_company/api_company_service.dart';
import 'src/slices/api_email_msg/api_email_msg_service.dart';
import 'src/slices/api_email_sender/api_email_sender_service.dart';
import 'src/slices/api_knowledge/api_knowledge_service.dart';
import 'src/slices/api_oauth/api_oauth_service.dart';
import 'src/slices/data_fetch/data_fetch_service.dart';
import 'src/slices/data_push/data_push_service.dart';
import 'src/slices/home_screen/home_screen_service.dart';
import 'src/utils/database.dart' as db;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  ConfigLog();
  await ConfigAmplitude.init();
  await Firebase.initializeApp();

  FlutterSecureStorage secureStorage = FlutterSecureStorage();
  Httpp httpp = Httpp(useClient: () => SentryHttpClient());
  HomeScreenService home = HomeScreenService();
  Login login = Login(
      style: style(),
      httpp: httpp,
      secureStorage: secureStorage,
      home: home.presenter);
  home.presenter.inject(
      () => provide(login: login, secureStorage: secureStorage, httpp: httpp));
  await login.init();
  return SentryFlutter.init(
      (options) async => options
        ..dsn = ConfigSentry.dsn
        ..environment = ConfigSentry.environment
        ..release = (await PackageInfo.fromPlatform()).version
        ..sendDefaultPii = false
        ..diagnosticLevel = SentryLevel.info
        ..sampleRate = 1.0,
      appRunner: () => runApp(App(login.routerDelegate)));
}

Future<List<SingleChildWidget>> provide(
    {FlutterSecureStorage? secureStorage,
    Httpp? httpp,
    required Login login}) async {
  Logger log = Logger('HomeScreenService.provide');
  TikiKeysService tikiKeysService =
      TikiKeysService(secureStorage: secureStorage);
  FlowModelUser? user = await login.user;
  TikiKeysModel? keys =
      user?.address != null ? await tikiKeysService.get(user!.address!) : null;
  if (user == null || user.address == null || keys == null) {
    log.severe('Attempting to open home page without a valid user');
    await login.logout();
    return [];
  } else {
    Database database = await db.open(keys.data.encode());

    ApiAppDataService apiAppDataService = ApiAppDataService(database: database);
    login.onLogout('ApiAppDataService',
        () async => await apiAppDataService.deleteAllData());

    ApiKnowledgeService apiKnowledgeService =
        ApiKnowledgeService(_helperApiAuth);
    DataPushService dataPushService = DataPushService(
        apiKnowledgeService: apiKnowledgeService, database: database);

    ApiEmailSenderService apiEmailSenderService =
        ApiEmailSenderService(database: database);
    ApiEmailMsgService apiEmailMsgService =
        ApiEmailMsgService(database: database);
    ApiCompanyService apiCompanyService = ApiCompanyService(
        database: database,
        helperApiAuth: _helperApiAuth,
        apiKnowledgeService: apiKnowledgeService);

    ApiOAuthService apiAuthService = ApiOAuthService(
        httpp: httpp ?? Httpp(),
        database: database,
        apiAppDataService: apiAppDataService);
    login.onLogout(
        'ApiAuthService', () async => await apiAuthService.signOutAll());

    DataFetchService dataFetchService = DataFetchService(
        apiAuthService: apiAuthService,
        apiAppDataService: apiAppDataService,
        apiCompanyService: apiCompanyService,
        apiEmailSenderService: apiEmailSenderService,
        apiEmailMsgService: apiEmailMsgService,
        apiKnowledgeService: apiKnowledgeService,
        dataPushService: dataPushService,
        database: database);

    return [
      Provider<ApiCompanyService>.value(value: apiCompanyService),
      Provider<ApiEmailSenderService>.value(value: apiEmailSenderService),
      Provider<ApiEmailMsgService>.value(value: apiEmailMsgService),
      Provider<ApiAppDataService>.value(value: apiAppDataService),
      Provider<ApiOAuthService>.value(value: apiAuthService),
      Provider<ApiKnowledgeService>.value(value: apiKnowledgeService),
      Provider<DataPushService>.value(value: dataPushService),
      ChangeNotifierProvider<DataFetchService>.value(value: dataFetchService),
    ];
  }
}

FlowStyle style() {
  return FlowStyle(
      intro: ScreenIntroStyle(
          backgroundColor1: ConfigColor.yellow,
          backgroundColor2: ConfigColor.lightYellow,
          backgroundColor3: ConfigColor.lightOrange,
          buttonColor: ConfigColor.tikiPurple,
          buttonTextColor: ConfigColor.white,
          textColor: ConfigColor.tikiPurple,
          skipColor: ConfigColor.tikiBlue,
          dotColor: ConfigColor.white,
          dotColorActive: ConfigColor.tikiPurple,
          textFamily: ConfigFont.familyNunitoSans,
          titleFamily: ConfigFont.familyKoara),
      email: ScreenEmailStyle(
          errorColor: ConfigColor.tikiRed,
          buttonColor: ConfigColor.tikiPurple,
          textColor: ConfigColor.greySeven,
          backgroundColor: ConfigColor.cream,
          buttonTextColor: ConfigColor.white,
          hintColor: ConfigColor.greyFive,
          linkColor: ConfigColor.orange,
          titleColor: ConfigColor.tikiPurple,
          textFamily: ConfigFont.familyNunitoSans,
          titleFamily: ConfigFont.familyKoara),
      inbox: ScreenInboxStyle(
          buttonColor: ConfigColor.orange,
          backgroundColor: ConfigColor.cream,
          textColor: ConfigColor.greySeven,
          titleColor: ConfigColor.tikiPurple,
          textFamily: ConfigFont.familyNunitoSans,
          titleFamily: ConfigFont.familyNunitoSans),
      terms: ScreenTermsStyle(
          backgroundColor: ConfigColor.cream,
          textColor: ConfigColor.greySeven,
          headingColor: ConfigColor.tikiPurple,
          linkColor: ConfigColor.orange,
          titleFamily: ConfigFont.familyKoara,
          textFamily: ConfigFont.familyNunitoSans),
      recover: ModalRecoverStyle(
        textColor: ConfigColor.tikiPurple,
        backgroundColor: ConfigColor.white,
        buttonColor: ConfigColor.orange,
        errorColor: ConfigColor.tikiRed,
        buttonTextColor: ConfigColor.white,
        hintColor: ConfigColor.greySix,
        fontFamily: ConfigFont.familyNunitoSans,
      ));
}
