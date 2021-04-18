import 'package:app/src/configs/config_sentry.dart' as ConfigSentry;
import 'package:app/src/helpers/helper_login/helper_login_bloc.dart';
import 'package:app/src/repos/repo_ss_security_keys/repo_ss_security_keys_bloc.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_bloc.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_model.dart';
import 'package:app/src/utilities/utility_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
  RepoSSUserModel user = await HelperLoginBloc.getLoggedInUser(
      RepoSSUserBloc(flutterSecureStorage),
      RepoSSSecurityKeysBloc(flutterSecureStorage));

  await SentryFlutter.init(
      (options) async => options
        ..dsn = ConfigSentry.of(ConfigSentry.dsn)
        ..environment = ConfigSentry.of(ConfigSentry.environment)
        ..release = await version()
        ..sendDefaultPii = false,
      appRunner: () => runApp(App(user)));
}
