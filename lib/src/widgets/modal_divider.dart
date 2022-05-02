/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:tiki_style/tiki_style.dart';

class ModalDivider extends StatelessWidget {
  const ModalDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            height: SizeProvider.instance.size(4),
            width: SizeProvider.instance.size(50),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(SizeProvider.instance.size(8))),
                color: ColorProvider.greyThree)));
  }
}
