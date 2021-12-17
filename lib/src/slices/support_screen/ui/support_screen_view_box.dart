import 'package:app/src/config/config_color.dart';
import 'package:app/src/widgets/tiki_card/tiki_card_view_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sizer/sizer.dart';

import 'support_screen_view_box_content.dart';
import 'support_screen_view_box_subtitle.dart';

class SupportScreenViewBox extends StatelessWidget {
  final String title;
  final String subtitle;
  final String content;

  const SupportScreenViewBox({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: ConfigColor.greyTwo,
          borderRadius: BorderRadius.circular(24)
        ),
        child: Column(children:<Widget>[
          TikiCardViewTitle(title),
          SupportScreenViewBoxSubtitle(),
          SupportScreenViewBoxContent()
        ])
    );
  }
}


