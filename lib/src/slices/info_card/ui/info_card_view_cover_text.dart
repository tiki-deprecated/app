import 'package:app/src/config/config_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../info_card_service.dart';

class InforCardViewCoverText extends StatelessWidget {
  final Animation<double> controllerValue;

  InforCardViewCoverText(this.controllerValue);

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<InfoCardService>(context);
    return Padding(
        padding: EdgeInsets.only(
          top: 59.h,
        ),
        child: Opacity(
            opacity: controllerValue.value * 3 <= 1
                ? 1 - (controllerValue.value * 3)
                : 0,
            child: Container(
                margin: EdgeInsets.only(top: 1.16.h),
                width: double.maxFinite,
                child: Text(service.model.coverData.subText,
                    style: TextStyle(
                        color: ConfigColor.tikiBlue,
                        fontFamily: "NunitoSans",
                        fontSize: 2.09.h,
                        fontWeight: FontWeight.w600)))));
  }
}
