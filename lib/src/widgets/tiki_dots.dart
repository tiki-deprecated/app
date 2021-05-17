/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/material.dart';

class TikiDots extends StatelessWidget {
  final int size;
  final int pos;

  TikiDots(this.size, this.pos);

  @override
  Widget build(BuildContext context) {
    return Row(
        children: List.generate(size, (i) => _dot(i == pos ? true : false)));
  }

  Widget _dot(bool active) {
    final double _size = 1 * PlatformRelativeSize.blockVertical;

    return Container(
      height: _size,
      width: _size,
      margin: EdgeInsets.symmetric(horizontal: _size * 0.5),
      decoration: BoxDecoration(
          color: active ? ConfigColor.mardiGras : ConfigColor.white,
          borderRadius: BorderRadius.all(Radius.circular(_size * 2))),
    );
  }
}
