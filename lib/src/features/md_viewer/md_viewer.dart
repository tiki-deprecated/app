/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper/helper-markdown.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:app/src/widgets/components/tiki_inputs/tiki_back_button.dart';
import 'package:app/src/widgets/screens/tiki_background.dart';
import 'package:app/src/widgets/screens/tiki_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MdViewer extends StatelessWidget {
  static final double _marginTop = 2 * PlatformRelativeSize.blockVertical;
  static final double _marginBottom = 12 * PlatformRelativeSize.blockVertical;
  final String markdownSource;

  const MdViewer(this.markdownSource);

  Widget _background() {
    return TikiBackground(
      backgroundColor: ConfigColor.serenade,
      topRight: HelperImage("home-blob-tr"),
      bottomRight: HelperImage("home-pineapple"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TikiScaffold(
        foregroundChildren: [
          TikiBackButton(),
          Container(
              margin: EdgeInsets.only(top: _marginTop, bottom: _marginBottom),
              child: HelperMarkdown(markdownSource))
        ], //_foreground(context),
        background: _background() as TikiBackground?);
  }
}
