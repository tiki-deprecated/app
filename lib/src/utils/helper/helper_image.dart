/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';

class HelperImage extends StatelessWidget {
  final String image;

  final double? height;

  final double? width;

  HelperImage(this.image, {this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Image(image: AssetImage('res/images/' + image + '.png'), width: this.width, height: this.height,);
  }
}
