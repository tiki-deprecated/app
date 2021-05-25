/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/repo/repo_api_website_users/repo_api_website_users.dart';
import 'package:app/src/features/repo/repo_api_website_users/repo_api_website_users_rsp.dart';
import 'package:app/src/utils/helper/helper_api_rsp.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_counter_state.dart';

class HomeCounterCubit extends Cubit<HomeCounterState> {
  final RepoApiWebsiteUsers _repoApiWebsiteUsers;

  HomeCounterCubit(this._repoApiWebsiteUsers) : super(HomeCounterInitial(0));

  HomeCounterCubit.provide(BuildContext context)
      : _repoApiWebsiteUsers =
            RepositoryProvider.of<RepoApiWebsiteUsers>(context),
        super(HomeCounterInitial(0));

  Future<void> update() async {
    HelperApiRsp<RepoApiWebsiteUsersRsp> apiRsp =
        await _repoApiWebsiteUsers.total();
    if (apiRsp.code == 200) {
      RepoApiWebsiteUsersRsp rsp = apiRsp.data;
      emit(HomeCounterSuccess(rsp.total));
    } else
      emit(HomeCounterFailure(state.count));
  }
}
