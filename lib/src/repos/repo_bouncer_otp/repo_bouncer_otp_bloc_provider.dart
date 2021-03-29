/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/repos/repo_bouncer_otp/repo_bouncer_otp_bloc.dart';
import 'package:flutter/cupertino.dart';

class RepoBouncerOtpBlocProvider extends InheritedWidget {
  final RepoBouncerOtpBloc _bloc;

  RepoBouncerOtpBlocProvider({Key key, Widget child})
      : _bloc = RepoBouncerOtpBloc(),
        super(key: key, child: child);

  RepoBouncerOtpBloc get bloc => _bloc;

  static RepoBouncerOtpBlocProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<RepoBouncerOtpBlocProvider>();
  }

  @override
  bool updateShouldNotify(RepoBouncerOtpBlocProvider oldWidget) {
    return false;
  }
}
