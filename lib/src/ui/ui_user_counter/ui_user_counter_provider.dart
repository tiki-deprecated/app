/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/repos/repo_website_users/repo_website_users_bloc.dart';
import 'package:app/src/ui/ui_user_counter/ui_user_counter_bloc.dart';
import 'package:flutter/cupertino.dart';

class UIUserCounterProvider extends InheritedWidget {
  final UIUserCounterBloc _bloc;

  UIUserCounterProvider(RepoWebsiteUsersBloc repoWebsiteUsersBloc,
      {Key key, Widget child})
      : _bloc = UIUserCounterBloc(repoWebsiteUsersBloc),
        super(key: key, child: child);

  UIUserCounterBloc get bloc => _bloc;

  static UIUserCounterProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UIUserCounterProvider>();
  }

  @override
  bool updateShouldNotify(UIUserCounterProvider oldWidget) {
    return false;
  }
}
