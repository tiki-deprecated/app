/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../intro_screen_service.dart';

class IntroScreenDots extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<IntroScreenService>(context).model;
    var size = model.cards.length;
    var pos = model.currentCard;
    return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(size, (i) => _dot(i == pos ? true : false)));
  }

  Widget _dot(bool active) {
    var size = 0.9.h;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size * 0.5),
      height: size,
      width: size,
      decoration: BoxDecoration(
          color: active ? ConfigColor.tikiPurple : ConfigColor.white,
          borderRadius: BorderRadius.all(Radius.circular(size * 2))),
    );
  }
}
