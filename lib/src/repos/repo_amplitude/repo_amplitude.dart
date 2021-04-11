/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/repos/repo_amplitude/repo_amplitude_bloc_provider.dart';
import 'package:flutter/cupertino.dart';

class RepoAmplitude extends StatelessWidget {
  final Widget _child;
  RepoAmplitude({Widget child}) : this._child = child;

  @override
  Widget build(BuildContext context) {
    return RepoAmplitudeBlocProvider(child: _child);
  }
}
