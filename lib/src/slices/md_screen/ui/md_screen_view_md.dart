/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../md_screen_service.dart';

class MdScreenView extends StatelessWidget {
  static const num _fontSizeHeading = 24;
  static const num _fontSizeText = 13;

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<MdScreenService>(context);
    return FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('res/md/' + service.model.filename + '.md'),
        builder: (BuildContext context, AsyncSnapshot<String> mdSource) {
          return MarkdownBody(
              selectable: true,
              onTapLink: (String text, String? href, String title) async =>
                  service.controller.openUrl(href),
              styleSheet: MarkdownStyleSheet(
                h1: TextStyle(
                    color: ConfigColor.tikiPurple,
                    fontSize: _relativeHeadingSize(1).sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Koara'),
                h3: TextStyle(
                    fontSize: _relativeHeadingSize(0.3).sp,
                    color: ConfigColor.tikiPurple,
                    fontWeight: FontWeight.w600),
                h4: TextStyle(
                    fontSize: _relativeHeadingSize(0.1).sp,
                    color: ConfigColor.tikiPurple,
                    fontWeight: FontWeight.w600),
                a: TextStyle(
                    color: ConfigColor.orange,
                    fontWeight: FontWeight.w600,
                    fontSize: _fontSizeText.sp),
                p: TextStyle(
                    color: ConfigColor.greySeven,
                    fontWeight: FontWeight.normal,
                    fontSize: _fontSizeText.sp),
              ),
              data: mdSource.data ?? ""); //mdSource.data
        });
  }

  double _relativeHeadingSize(double factor) {
    return ((_fontSizeHeading - _fontSizeText) * factor) + _fontSizeText;
  }
}
