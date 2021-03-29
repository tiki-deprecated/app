/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/repos/repo_website_users/repo_website_users_bloc.dart';
import 'package:flutter/cupertino.dart';

class RepoWebsiteUsersBlocProvider extends InheritedWidget {
  final RepoWebsiteUsersBloc _bloc;

  RepoWebsiteUsersBlocProvider({Key key, Widget child})
      : _bloc = RepoWebsiteUsersBloc(),
        super(key: key, child: child);

  RepoWebsiteUsersBloc get bloc => _bloc;

  static RepoWebsiteUsersBlocProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<RepoWebsiteUsersBlocProvider>();
  }

  @override
  bool updateShouldNotify(RepoWebsiteUsersBlocProvider oldWidget) {
    return false;
  }
}
