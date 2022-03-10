/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/config_color.dart';
import '../../info_carousel_card_service.dart';

class InfoCarouselCardViewCoverSubtitle extends StatelessWidget {
  final Animation<double> _animationValue;

  const InfoCarouselCardViewCoverSubtitle(this._animationValue, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<InfoCarouselCardService>(context);
    return Opacity(
        opacity: _animationValue.value * 2 <= 1
            ? 1 - (_animationValue.value * 2)
            : 0,
        child: Text(service.model.cover!.subtitle!,
            style: TextStyle(
                color: ConfigColor.orange,
                fontSize: 13.sp,
                fontWeight: FontWeight.w800,
                fontFamily: "NunitoSans")));
  }
}
