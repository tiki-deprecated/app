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
    var service = Provider.of<IntroScreenService>(context, listen: false);
    var marginTop = service.presenter.margins['marginTopText'];
    var marginRight = service.presenter.margins['marginRightText'];
    return Container(
        margin: EdgeInsets.only(top: marginTop, right: marginRight),
        alignment: Alignment.centerLeft,
        child: tikiDots(service.model.getTotalSlides(),
            service.model.getCurrentSlideIndex()));
  }

  Widget tikiDots(size, pos) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(size, (i) => _dot(i == pos ? true : false)));
  }

  Widget _dot(bool active) {
    num size = 1.h;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size * 0.5),
      decoration: BoxDecoration(
          color: active ? ConfigColor.mardiGras : ConfigColor.white,
          borderRadius: BorderRadius.all(Radius.circular(size * 2))),
    );
  }
}
