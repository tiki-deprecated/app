/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelperDynamicLink extends StatefulWidget {
  final Widget _child;

  HelperDynamicLink(this._child);

  @override
  State<StatefulWidget> createState() => _HelperDynamicLink(_child);
}

class _HelperDynamicLink extends State<HelperDynamicLink> {
  final Widget _child;

  _HelperDynamicLink(this._child);

  String link = "NA";

  @override
  void initState() {
    super.initState();
    this.initDynamicLinks();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text("link is: " + link,
            style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.normal,
                color: Colors.white,
                fontSize: 20))); //_child;
  }

  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;

      if (deepLink != null) {
        setState(() {
          link = deepLink.path;
        });
        Navigator.pushNamed(context, deepLink.path);
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      setState(() {
        link = deepLink.path;
      });
      Navigator.pushNamed(context, deepLink.path);
    }
  }
}
