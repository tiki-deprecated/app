/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_navigate.dart';
import 'package:app/src/features/repo/repo_local_ss_current/repo_local_ss_current.dart';
import 'package:app/src/features/repo/repo_local_ss_current/repo_local_ss_current_model.dart';
import 'package:app/src/features/repo/repo_local_ss_user/repo_local_ss_user.dart';
import 'package:app/src/features/repo/repo_local_ss_user/repo_local_ss_user_model.dart';
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
