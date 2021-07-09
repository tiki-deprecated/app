import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:app/src/widgets/tiki_card/tiki_card_controller.dart';
import 'package:app/src/widgets/tiki_card/tiki_card_layout.dart';
import 'package:app/src/widgets/tiki_card/tiki_card_view_cta_inline.dart';
import 'package:app/src/widgets/tiki_card/tiki_card_view_figure.dart';
import 'package:app/src/widgets/tiki_card/tiki_card_view_text.dart';
import 'package:app/src/widgets/tiki_card/tiki_card_view_title.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UserAccountModalViewNews extends StatelessWidget {
  static const String _title = "Latest news";
  static const String _text =
      "For the latest news and updates, check out our blog.";
  static const String _cta = "Read More";
  static const String _url = "https://mytiki.com/blog";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: TikiCardLayout(
          TikiCardViewTitle(_title),
          TikiCardViewText(_text),
          TikiCardViewFigure(HelperImage("tiki-news")),
          cta: TikiCardViewCtaInline(
              Text(_cta,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.5.sp,
                      color: ConfigColor.orange)),
              Icon(Icons.arrow_forward,
                  color: ConfigColor.orange, size: 12.5.sp),
              () => TikiCardController.launchUrl(_url)),
        ),
        onTap: () => TikiCardController.launchUrl(_url));
  }
}
