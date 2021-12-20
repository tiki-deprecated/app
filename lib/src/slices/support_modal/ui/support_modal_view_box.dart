import 'package:flutter/material.dart';

import '../../../config/config_color.dart';
import '../../../widgets/tiki_card/tiki_card_view_title.dart';
import 'support_modal_view_box_content.dart';
import 'support_modal_view_box_subtitle.dart';

class SupportModalViewBox extends StatelessWidget {
  static const double _cardMarginTop = 2.25;
  final dynamic data;

  const SupportModalViewBox(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: _cardMarginTop),
        decoration: BoxDecoration(
            color: ConfigColor.greyTwo,
            borderRadius: BorderRadius.circular(24)),
        child: Column(children: <Widget>[
          TikiCardViewTitle(data.title),
          SupportModalViewBoxSubtitle(data),
          SupportModalViewBoxContent(data)
        ]));
  }
}
