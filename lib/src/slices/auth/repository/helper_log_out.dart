/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_navigate.dart';
import 'package:app/src/repositories/repo_local_ss_current/app_model_current.dart';
import 'package:app/src/repositories/repo_local_ss_current/secure_storage_repository_current.dart';
import 'package:app/src/repositories/repo_local_ss_user/app_model_user.dart';
import 'package:app/src/repositories/repo_local_ss_user/secure_storage_repository_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HelperLogOut {
  final RepoLocalSsUser _repoLocalSsUser;
  final RepoLocalSsCurrent _repoLocalSsCurrent;

  HelperLogOut(this._repoLocalSsUser, this._repoLocalSsCurrent);

  HelperLogOut.provide(BuildContext context)
      : _repoLocalSsUser = RepositoryProvider.of<RepoLocalSsUser>(context),
        _repoLocalSsCurrent =
            RepositoryProvider.of<RepoLocalSsCurrent>(context);

  Future<void> user(BuildContext context, String email) async {
    RepoLocalSsUserModel user = await _repoLocalSsUser.find(email);
    user.isLoggedIn = false;
    await _repoLocalSsUser.save(email, user);
    Navigator.of(context).pushNamedAndRemoveUntil(
        ConfigNavigate.path.loginEmail, (route) => false);
  }

  Future<void> current(BuildContext context) async {
    RepoLocalSsCurrentModel current =
        await _repoLocalSsCurrent.find(RepoLocalSsCurrent.key);
    RepoLocalSsUserModel user = await _repoLocalSsUser.find(current.email!);
    user.isLoggedIn = false;
    await _repoLocalSsUser.save(current.email!, user);
    Navigator.of(context).pushNamedAndRemoveUntil(
        ConfigNavigate.path.loginEmail, (route) => false);
  }
}
