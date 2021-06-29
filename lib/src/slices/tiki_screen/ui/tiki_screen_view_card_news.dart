import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_card/tiki_card.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_card/tiki_card_cta_inline.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_card/tiki_card_figure.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_card/tiki_card_text.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_card/tiki_card_title.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../tiki_screen_service.dart';

class TikiScreenViewCardNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<TikiScreenService>(context);
    return GestureDetector(
        child: TikiCard(
          TikiCardTitle(service.presenter.textCardNewsTitle),
          TikiCardText(service.presenter.textCardNewsText),
          TikiCardFigure(HelperImage("tiki-news")),
          cta: TikiCardCtaInline(
              Text(service.presenter.textCardNewsCtaText,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: service.presenter.fontSizeCardCta.sp,
                      color: ConfigColor.orange)),
              Icon(Icons.arrow_forward, color: ConfigColor.orange),
              () => service.controller.launchUrl("https://medium.com/mytiki")),
        ),
        onTap: () => service.controller.launchUrl("https://medium.com/mytiki"));
  }
}
