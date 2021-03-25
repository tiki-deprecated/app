/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt_bloc_provider.dart';
import 'package:flutter/cupertino.dart';

class RepoBouncerJwt extends StatelessWidget {
  final Widget _child;
  RepoBouncerJwt({Widget child}) : this._child = child;

  @override
  Widget build(BuildContext context) {
    return RepoBouncerJwtBlocProvider(child: _child);
  }
}
