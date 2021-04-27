/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';

class HelperImage extends StatelessWidget {
  final String image;

  HelperImage(this.image);

  @override
  Widget build(BuildContext context) {
    return Image(image: AssetImage('res/images/' + image + '.png'));
  }
}
