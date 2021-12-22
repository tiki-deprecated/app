import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../../../config/config_font.dart';
import '../support_modal_service.dart';
import 'support_modal_view_box_content.dart';
import 'support_modal_view_box_subtitle.dart';

class SupportModalViewBox extends StatelessWidget {
  static const double _cardMarginTop = 2.25;
  final dynamic data;

  const SupportModalViewBox(this.data);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => handleTap(context),
        child: Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: _cardMarginTop.h),
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            decoration: BoxDecoration(
                color: ConfigColor.white,
                borderRadius: BorderRadius.circular(24)),
            child: Column(children: <Widget>[
              SupportModalViewBoxTitle(data),
              SupportModalViewBoxSubtitle(data),
              SupportModalViewBoxContent(data)
            ])));
  }

  handleTap(BuildContext context) {
    SupportModalService service =
        Provider.of<SupportModalService>(context, listen: false);
    service.controller.onBoxTap(this.data);
  }
}

class SupportModalViewBoxTitle extends StatelessWidget {
  final dynamic data;

  const SupportModalViewBoxTitle(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        child: Text(data.title ?? "",
            style: TextStyle(
                color: ConfigColor.tikiPurple,
                fontSize: 20.sp,
                fontFamily: ConfigFont.familyNunitoSans,
                fontWeight: FontWeight.w700)));
  }
}
