/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/repo/repo_api_website_users/repo_api_website_users.dart';
import 'package:app/src/features/repo/repo_local_ss_current/repo_local_ss_current.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'features/login/login_otp_req/login_otp_req_bloc.dart';
import 'features/login/login_otp_valid/login_otp_valid_cubit.dart';
import 'features/repo/repo_api_bouncer_jwt/repo_api_bouncer_jwt.dart';
import 'features/repo/repo_api_bouncer_otp/repo_api_bouncer_otp.dart';
import 'features/repo/repo_local_ss_keys/repo_local_ss_keys.dart';
import 'features/repo/repo_local_ss_otp/repo_local_ss_otp.dart';
import 'features/repo/repo_local_ss_token/repo_local_ss_token.dart';
import 'features/repo/repo_local_ss_user/repo_local_ss_user.dart';

class Provide {
  static Widget chain(Widget child) {
    return _repos(_otp(child));
  }

  static Widget _repos(Widget child) {
    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    return MultiRepositoryProvider(providers: [
      RepositoryProvider<RepoLocalSsUser>(
        create: (context) => RepoLocalSsUser(secureStorage: secureStorage),
      ),
      RepositoryProvider<RepoLocalSsToken>(
        create: (context) => RepoLocalSsToken(secureStorage: secureStorage),
      ),
      RepositoryProvider<RepoLocalSsKeys>(
        create: (context) => RepoLocalSsKeys(secureStorage: secureStorage),
      ),
      RepositoryProvider<RepoLocalSsOtp>(
        create: (context) => RepoLocalSsOtp(secureStorage: secureStorage),
      ),
      RepositoryProvider<RepoLocalSsCurrent>(
        create: (context) => RepoLocalSsCurrent(secureStorage: secureStorage),
      ),
      RepositoryProvider<RepoApiBouncerOtp>(
        create: (context) => RepoApiBouncerOtp(),
      ),
      RepositoryProvider<RepoApiBouncerJwt>(
        create: (context) => RepoApiBouncerJwt(),
      ),
      RepositoryProvider<RepoApiWebsiteUsers>(
        create: (context) => RepoApiWebsiteUsers(),
      ),
    ], child: child);
  }

  static Widget _otp(Widget child) {
    return MultiBlocProvider(providers: [
      BlocProvider<LoginOtpReqBloc>(
          create: (context) => LoginOtpReqBloc.provide(context)),
      BlocProvider<LoginOtpValidCubit>(
          create: (context) => LoginOtpValidCubit.provide(context))
    ], child: child);
  }
}
