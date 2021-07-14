import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:app/src/widgets/tiki_card/tiki_card.dart';
import 'package:app/src/widgets/tiki_card/tiki_card_controller.dart';
import 'package:app/src/widgets/tiki_card/tiki_card_view_cta_inline.dart';
import 'package:app/src/widgets/tiki_card/tiki_card_view_figure.dart';
import 'package:app/src/widgets/tiki_card/tiki_card_view_text.dart';
import 'package:app/src/widgets/tiki_card/tiki_card_view_title.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UserAccountModalViewRelease extends StatelessWidget {
  static const String _title = "Coming next";
  static const String _text = "See which companies \nemail you";
  static const String _cta = "Read More";
  static const String _url = "https://mytiki.com/blog/peek-TIKI-app-prototype";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: TikiCard(
          TikiCardViewTitle(_title),
          TikiCardViewText(_text),
          TikiCardViewFigure(HelperImage("email-see")),
          cta: TikiCardViewCtaInline(
              Text(_cta,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.5.sp,
                      color: ConfigColor.orange)),
              Icon(Icons.arrow_forward, color: ConfigColor.orange),
              () => TikiCardController.launchUrl(_url)),
        ),
        onTap: () => TikiCardController.launchUrl(_url));
  }
}
