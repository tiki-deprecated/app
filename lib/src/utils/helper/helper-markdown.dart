/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class HelperMarkdown extends StatelessWidget {
  final String source;

  HelperMarkdown(this.source);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString(
            'res/md/' + source + '.md'),
        builder: (BuildContext context, AsyncSnapshot<String> mdSource) {
          return Markdown(data: mdSource.data!);
        }
    );
  }
}