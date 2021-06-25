import 'package:app/src/slices/info_card/info_card_service.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class InforCardViewCoverSwipeUp extends StatelessWidget {
  final Animation<double> controllerValue;

  InforCardViewCoverSwipeUp(this.controllerValue);

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<InfoCardService>(context);
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            height: service.controller
                .calculateAnimation(6.98.h, this.controllerValue.value, 0),
            child: Opacity(
                opacity: this.controllerValue.value * 2 <= 1
                    ? 1 - (this.controllerValue.value * 2)
                    : 0,
                child: Container(
                  height: service.controller
                      .calculateAnimation(60, this.controllerValue.value, 0),
                  padding: EdgeInsets.only(bottom: 16),
                  child: HelperImage(
                    "arrow-up",
                    width: 14.5.w,
                  ),
                ))));
  }
}
