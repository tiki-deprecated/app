/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/app.dart';
import 'package:app/src/helpers/helper_dynamic_link/helper_dynamic_link_bloc_model_blockchain.dart';
import 'package:app/src/helpers/helper_dynamic_link/helper_dynamic_link_bloc_model_bouncer.dart';
import 'package:app/src/helpers/helper_dynamic_link/helper_dynamic_link_bloc_provider.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class HelperDynamicLinkRouter extends StatefulWidget {
  final Widget _child;
  HelperDynamicLinkRouter({Widget child}) : this._child = child;

  @override
  State<StatefulWidget> createState() => _HelperDynamicLinkView(child: _child);
}

class _HelperDynamicLinkView extends State<HelperDynamicLinkRouter> {
  final Widget _child;
  static const String _dlPathBouncer = "/app/bouncer";
  static const String _dlPathBlockchain = "/app/blockchain";

  _HelperDynamicLinkView({Widget child}) : this._child = child;

  @override
  Widget build(BuildContext context) {
    return _child;
  }

  @override
  void initState() {
    super.initState();
    this.initDynamicLinks();
  }

  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;
      if (deepLink != null) _route(deepLink);
    }, onError: (OnLinkErrorException e) async {
      await Sentry.captureException(e, stackTrace: StackTrace.current);
    });

    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;
    if (deepLink != null) _route(deepLink);
  }

  void _route(Uri link) {
    switch (link.path) {
      case _dlPathBouncer:
        return _routeBouncer(link);
      case _dlPathBlockchain:
        return _routeBlockchain(link);
      default:
        return;
    }
  }

  void _routeBouncer(Uri link) {
    String otp = link.queryParameters["otp"];
    if (otp != null && otp.isNotEmpty) {
      HelperDynamicLinkBlocProvider.of(navigatorKey.currentContext)
          .bloc
          .initBouncer(HelperDynamicLinkBlocModelBouncer(otp: otp));
      navigatorKey.currentState
          .pushNamedAndRemoveUntil(App.appPathLoginOtp, (_) => false);
    }
  }

  void _routeBlockchain(Uri link) {
    String ref = link.queryParameters["ref"];
    if (ref != null && ref.isNotEmpty) {
      HelperDynamicLinkBlocProvider.of(navigatorKey.currentContext)
          .bloc
          .initBlockchain(HelperDynamicLinkBlocModelBlockchain(ref: ref));
      navigatorKey.currentState
          .pushNamedAndRemoveUntil(App.appPathEntry, (_) => false);
    }
  }
}
