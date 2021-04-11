/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/repos/repo_amplitude/repo_amplitude_bloc.dart';
import 'package:flutter/cupertino.dart';

class RepoAmplitudeBlocProvider extends InheritedWidget {
  final RepoAmplitudeBloc _bloc;

  RepoAmplitudeBlocProvider({Key key, Widget child})
      : _bloc = RepoAmplitudeBloc(),
        super(key: key, child: child);

  RepoAmplitudeBloc get bloc => _bloc;

  static RepoAmplitudeBlocProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<RepoAmplitudeBlocProvider>();
  }

  @override
  bool updateShouldNotify(RepoAmplitudeBlocProvider oldWidget) {
    return false;
  }
}
