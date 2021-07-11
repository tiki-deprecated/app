/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/md_viewer/ui/md_viewer_layout_background.dart';
import 'package:app/src/slices/md_viewer/ui/md_viewer_layout_foreground.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MdViewerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: GestureDetector(
                child: Stack(children: [
      MdViewerLayoutBackground(),
      MdViewerLayoutForeground(),
    ]))));
  }
}
