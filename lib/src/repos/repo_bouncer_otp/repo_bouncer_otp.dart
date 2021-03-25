/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/repos/repo_bouncer_otp/repo_bouncer_otp_bloc_provider.dart';
import 'package:flutter/cupertino.dart';

class RepoBouncerOtp extends StatelessWidget {
  final Widget _child;
  RepoBouncerOtp({Widget child}) : this._child = child;

  @override
  Widget build(BuildContext context) {
    return RepoBouncerOtpBlocProvider(child: _child);
  }
}
