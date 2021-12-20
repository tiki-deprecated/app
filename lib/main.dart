import 'src/slices/api_zendesk/model/api_zendesk_article.dart';
import 'src/slices/api_zendesk/model/api_zendesk_category.dart';
import 'src/slices/api_zendesk/model/api_zendesk_section.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app.dart';
import 'src/config/config_amplitude.dart';
import 'src/config/config_log.dart';
import 'src/config/config_sentry.dart';
import 'src/slices/api_blockchain/api_blockchain_service.dart';
import 'src/slices/api_bouncer/api_bouncer_service.dart';
import 'src/slices/api_signup/api_signup_service.dart';
import 'src/slices/api_user/api_user_service.dart';
import 'src/slices/api_zendesk/api_zendesk_service.dart';
import 'src/slices/login_flow/login_flow_service.dart';
import 'src/utils/api/helper_api_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  ConfigLog();
  await ConfigAmplitude.init();
  await Firebase.initializeApp();
  return init();
}

Future<void> init() async {
  ApiUserService apiUserService = ApiUserService(FlutterSecureStorage());
  ApiBouncerService apiBouncerService = ApiBouncerService();
  LoginFlowService loginFlowService = LoginFlowService();
  HelperApiAuth helperApiAuth =
      HelperApiAuth(loginFlowService, apiBouncerService);
  ApiBlockchainService apiBlockchainService =
      ApiBlockchainService(helperApiAuth);

  await loginFlowService.initialize(
      apiUserService: apiUserService,
      apiBouncerService: apiBouncerService,
      apiBlockchainService: apiBlockchainService,
      helperApiAuth: helperApiAuth,
      logoutCallbacks: []);

  // ApiZendeskService apiZendeskService = ApiZendeskService();
  // List<ApiZendeskCategory> categories = await apiZendeskService.getZendeskCategories();
  // print(categories);
  // ApiZendeskCategory firstCategory = categories[0];
  // List<ApiZendeskSection> sections = await apiZendeskService.getZendeskSections(firstCategory.id);
  // print(sections);
  // ApiZendeskSection firstSection = sections[0];
  // List<ApiZendeskArticle> articles = await apiZendeskService.getZendeskArticles(firstSection.id);
  // print(articles);
  // ApiZendeskArticle firstArticle = articles[0];
  // ApiZendeskArticle article = await apiZendeskService.getZendeskArticle(firstArticle.id);
  // print(article);

  SentryFlutter.init(
      (options) async => options
        ..dsn = ConfigSentry.dsn
        ..environment = ConfigSentry.environment
        ..release = (await PackageInfo.fromPlatform()).version
        ..sendDefaultPii = false
        ..diagnosticLevel = SentryLevel.info
        ..sampleRate = 1.0,
      appRunner: () => runApp(MultiProvider(providers: [
            Provider<ApiUserService>.value(value: apiUserService),
            Provider<ApiBouncerService>.value(value: apiBouncerService),
            Provider<ApiBlockchainService>.value(value: apiBlockchainService),
            Provider<ApiSignupService>(create: (_) => ApiSignupService()),
          ], child: App(loginFlowService))));
}
