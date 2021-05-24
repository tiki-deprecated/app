/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper/helper-markdown.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/widgets/screens/tiki_background.dart';
import 'package:app/src/widgets/screens/tiki_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class MdViewer extends StatelessWidget {

  final String markdownSource;

  const MdViewer(this.markdownSource);

  Widget _background() {
    return TikiBackground(
      backgroundColor: ConfigColor.serenade,
      topRight: HelperImage("home-blob-tr"),
      center: Container(
        decoration: BoxDecoration(
          color: Colors.white, borderRadius:
        BorderRadius.circular(24),),
        padding: EdgeInsets.all(16),
        child: Expanded(child:HelperMarkdown(markdownSource)),
    ),
    bottomRight: HelperImage("home-pineapple"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TikiScaffold(
        foregroundChildren: [],//_foreground(context),
        background: _background() as TikiBackground?);
  }
}
