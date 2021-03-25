/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/repos/repo_bouncer_otp/repo_bouncer_otp_bloc_provider.dart';
import 'package:app/src/ui/ui_magiclink_send/ui_magic_link_view.dart';
import 'package:flutter/cupertino.dart';

import 'ui_magic_link_bloc_provider.dart';

class UIMagicLink extends StatelessWidget {
  final Widget _onSubmit;

  UIMagicLink(this._onSubmit);

  @override
  Widget build(BuildContext context) {
    return UIMagicLinkBlocProvider(RepoBouncerOtpBlocProvider.of(context).bloc,
        child: UIMagicLinkView(_onSubmit));
  }
}
