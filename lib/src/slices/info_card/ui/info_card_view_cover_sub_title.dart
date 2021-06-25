import 'package:app/src/slices/info_card/info_card_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class InforCardViewCoverSubTitle extends StatelessWidget {
  final Animation<double> controllerValue;

  InforCardViewCoverSubTitle(this.controllerValue);

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<InfoCardService>(context);
    return Positioned(
        top: 40.h,
        child: Container(
            height: service.controller
                .calculateAnimation(7.h, controllerValue.value, 0),
            child: Opacity(
                opacity: controllerValue.value * 2 <= 1
                    ? 1 - (controllerValue.value * 2)
                    : 0,
                child: Container(
                    height: service.controller
                        .calculateAnimation(6.98, controllerValue.value, 0),
                    margin: EdgeInsets.only(bottom: 10),
                    width: double.maxFinite,
                    child: Text(this.coverData['subtitle'],
                        style: TextStyle(
                            color: ConfigColor.orange,
                            fontSize: 2.3.sp,
                            fontWeight: FontWeight.w800,
                            fontFamily: "NunitoSans"))))));
  }
}
