import 'package:app/src/configs/config_sentry.dart' as ConfigSentry;
import 'package:app/src/helpers/helper_login/helper_login_bloc.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_bloc.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_model.dart';
import 'package:app/src/utilities/utility_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  RepoSSUserModel user = await HelperLoginBloc.getLoggedInUser(
      RepoSSUserBloc(FlutterSecureStorage()));

  await SentryFlutter.init(
      (options) async => options
        ..dsn = ConfigSentry.of(ConfigSentry.dsn)
        ..environment = ConfigSentry.of(ConfigSentry.environment)
        ..release = await version()
        ..sendDefaultPii = false,
      appRunner: () => runApp(App(user)));
}
