/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class HelperMarkdown extends StatelessWidget {
  static final double _fontSizeHeading = 10.w;
  static final double _fontSizeText = 4.w;

  final String source;

  HelperMarkdown(this.source);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('res/md/' + source + '.md'),
        builder: (BuildContext context, AsyncSnapshot<String> mdSource) {
          return MarkdownBody(
              selectable: true,
              onTapLink: (String text, String? href, String title) async {
                if (await canLaunch(href!)) await launch(href);
              },
              styleSheet: MarkdownStyleSheet(
                h1: TextStyle(
                    color: ConfigColor.mardiGras,
                    fontSize: _relativeHeadingSize(1),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Koara'),
                h3: TextStyle(
                    fontSize: _relativeHeadingSize(0.3),
                    color: ConfigColor.mardiGras,
                    fontWeight: FontWeight.w600),
                h4: TextStyle(
                    fontSize: _relativeHeadingSize(0.1),
                    color: ConfigColor.mardiGras,
                    fontWeight: FontWeight.w600),
                a: TextStyle(
                    color: ConfigColor.orange,
                    fontWeight: FontWeight.w600,
                    fontSize: _fontSizeText),
                p: TextStyle(
                    color: ConfigColor.emperor,
                    fontWeight: FontWeight.normal,
                    fontSize: _fontSizeText),
              ),
              data: mdSource.data ?? ""); //mdSource.data
        });
  }

  double _relativeHeadingSize(double factor) {
    return ((_fontSizeHeading - _fontSizeText) * factor) + _fontSizeText;
  }
}
