import '../../../config/config_color.dart';
import '../../../widgets/tiki_card/tiki_card_view_title.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'support_screen_view_box_content.dart';
import 'support_screen_view_box_subtitle.dart';

class SupportScreenViewBox extends StatelessWidget {
  static const double _cardMarginTop = 2.25;
  final dynamic data;

  const SupportScreenViewBox(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: _cardMarginTop),
        decoration: BoxDecoration(
            color: ConfigColor.greyTwo,
            borderRadius: BorderRadius.circular(24)),
        child: Column(children: <Widget>[
          TikiCardViewTitle(data.title),
          SupportScreenViewBoxSubtitle(data),
          SupportScreenViewBoxContent(data)
        ]));
  }
}
