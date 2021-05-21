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
  static const String _dlPathBouncer = "/app/bouncer";
  static const String _dlPathBlockchain = "/app/blockchain";

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

  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      final Uri? deepLink = dynamicLink?.link;
      if (deepLink != null) _handle(deepLink);
    }, onError: (OnLinkErrorException e) async {
      await Sentry.captureException(e, stackTrace: StackTrace.current);
    });

    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;
    if (deepLink != null) _handle(deepLink);
  }

  void _handle(Uri link) {
    if (link.path == _dlPathBouncer) {
      _handleBouncer(link);
    } else if (link.path == _dlPathBlockchain) {
      _handleBlockchain(link);
    }
  }

  void _handleBouncer(Uri link) {
    String? otp = link.queryParameters["otp"];
    if (otp != null && otp.isNotEmpty) {
      BlocProvider.of<LoginOtpValidBloc>(ConfigNavigate.key.currentContext!)
          .add(LoginOtpValidChanged(otp));
      Navigator.of(ConfigNavigate.key.currentContext!).pushNamedAndRemoveUntil(
          ConfigNavigate.path.loginOtp, (route) => false);
    }
  }

  void _handleBlockchain(Uri link) {
    String? ref = link.queryParameters["ref"];
    if (ref != null && ref.isNotEmpty) {
      BlocProvider.of<KeysReferralCubit>(context).updateReferer(ref);
    }
  }
}
