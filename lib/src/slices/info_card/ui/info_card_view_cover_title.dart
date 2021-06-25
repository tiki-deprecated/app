import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../info_card_service.dart';

class InforCardViewCoverTitle extends StatelessWidget {
  final Animation<double> controllerValue;

  InforCardViewCoverTitle(this.controllerValue);

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<InfoCardService>(context);
    return Padding(
        padding: EdgeInsets.only(
            top: service.controller
                .calculateAnimation(44.h, controllerValue.value, 2.32.h)),
        child: Align(
            alignment: Alignment(
              -controllerValue.value,
              -1,
            ),
            child: Container(
                width: service.controller.calculateAnimation(
                    MediaQuery.of(context).size.width,
                    controllerValue.value,
                    41.w),
                child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                        style: TextStyle(
                            color: Color(0xFF0036B5),
                            height: 1,
                            fontFamily: "Koara",
                            fontSize: service.controller.calculateAnimation(
                                5.23.h, controllerValue.value, 2.9.h),
                            fontWeight: FontWeight.bold),
                        text: this.coverData['bigTextLighter'],
                        children: [
                          TextSpan(
                              text: this.coverData['bigTextDarker'],
                              style: TextStyle(
                                  color: ConfigColor.tikiBlue,
                                  height: 1,
                                  fontFamily: "Koara",
                                  fontSize: service.controller
                                      .calculateAnimation(5.23.sp,
                                          controllerValue.value, 2.9.sp),
                                  fontWeight: FontWeight.bold))
                        ])))));
  }
}
