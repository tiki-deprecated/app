/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/repos/repo_website_users/repo_website_users_bloc.dart';
import 'package:app/src/repos/repo_website_users/repo_website_users_model_rsp.dart';
import 'package:app/src/ui/ui_user_counter/ui_user_counter_model.dart';
import 'package:rxdart/rxdart.dart';

class UIUserCounterBloc {
  RepoWebsiteUsersBloc _repoWebsiteUsersBloc;
  UIUserCounterModel _userCounterModel = UIUserCounterModel();
  BehaviorSubject<UIUserCounterModel> _subjectModel;

  UIUserCounterBloc(this._repoWebsiteUsersBloc) {
    _subjectModel = BehaviorSubject.seeded(_userCounterModel);
    update();
  }

  Observable<UIUserCounterModel> get observable => _subjectModel.stream;

  Future<void> update() async {
    RepoWebsiteUsersRsp rsp = await _repoWebsiteUsersBloc.get();
    if (rsp.total != null) {
      _userCounterModel.users = rsp.total;
      _subjectModel.sink.add(_userCounterModel);
    }
  }

  void dispose() {
    _subjectModel.close();
  }
}
