/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt_bloc.dart';
import 'package:flutter/cupertino.dart';

class RepoBouncerJwtBlocProvider extends InheritedWidget {
  final RepoBouncerJwtBloc _bloc;

  RepoBouncerJwtBlocProvider({Key key, Widget child})
      : _bloc = RepoBouncerJwtBloc(),
        super(key: key, child: child);

  RepoBouncerJwtBloc get bloc => _bloc;

  static RepoBouncerJwtBlocProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<RepoBouncerJwtBlocProvider>();
  }

  @override
  bool updateShouldNotify(RepoBouncerJwtBlocProvider oldWidget) {
    return false;
  }
}
