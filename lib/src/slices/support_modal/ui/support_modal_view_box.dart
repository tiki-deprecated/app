import 'support_modal_view_box_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../support_modal_service.dart';
import 'support_modal_view_box_content.dart';
import 'support_modal_view_box_subtitle.dart';

class SupportModalViewBox extends StatelessWidget {
  static const double _cardMarginTop = 2.25;
  final dynamic data;
  final bool excerpt;

  const SupportModalViewBox(this.data, {this.excerpt = true});

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
              SupportModalViewBoxContent(data, excerpt: this.excerpt)
            ])));
  }

  handleTap(BuildContext context) {
    SupportModalService service =
        Provider.of<SupportModalService>(context, listen: false);
    service.controller.onBoxTap(this.data);
  }
}
