/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_navigate.dart';
import 'package:app/src/features/keys/keys_referral/bloc/keys_referral_cubit.dart';
import 'package:app/src/features/login/login_otp/login_otp_valid/bloc/login_otp_valid_bloc.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class DynamicLinkHandler extends StatefulWidget {
  final Widget? _child;

  DynamicLinkHandler({Widget? child}) : this._child = child;

  @override
  State<StatefulWidget> createState() => _DynamicLinkHandler(child: _child);
}

class _DynamicLinkHandler extends State<DynamicLinkHandler> {
  final Widget? _child;


  _DynamicLinkHandler({Widget? child}) : this._child = child;

  @override
  Widget build(BuildContext context) {
    return _child!;
  }

  @override
  void initState() {
    super.initState();
    this.initDynamicLinks();
  }

}
