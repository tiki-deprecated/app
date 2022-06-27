/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';

import 'home_view_layout_stack.dart';

class HomeViewLayout extends StatelessWidget {
  const HomeViewLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => !Navigator.of(context).userGestureInProgress,
        child: const HomeViewLayoutStack());
  }
}
