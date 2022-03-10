/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';

class HelperImage extends StatelessWidget {
  final String image;

  final double? height;

  final double? width;

  const HelperImage(this.image, {Key? key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage('res/images/' + image + '.png'),
      width: width,
      height: height,
    );
  }
}
