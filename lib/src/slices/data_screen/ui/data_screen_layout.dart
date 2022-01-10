/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';

import '../../../config/config_color.dart';
import '../../../widgets/header_bar/header_bar.dart';
import 'data_screen_layout_body.dart';

class DataScreenLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Stack(children: [
      Container(color: ConfigColor.greyOne),
      SafeArea(
          child: Column(
              children: [HeaderBar(), Expanded(child: DataScreenLayoutBody())]))
    ])));
  }
}
