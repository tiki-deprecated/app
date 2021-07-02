import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/tiki_screen/tiki_screen_service.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_card/tiki_card.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_card/tiki_card_cta_inline.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_card/tiki_card_figure.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_card/tiki_card_text.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_card/tiki_card_title.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TikiScreenViewCardRelease extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<TikiScreenService>(context);
    return GestureDetector(
        child: TikiCard(
          TikiCardTitle(service.presenter.textCardReleaseTitle),
          TikiCardText(service.presenter.textCardReleaseText),
          TikiCardFigure(HelperImage("add-gmail")),
          cta: TikiCardCtaInline(
              Text(service.presenter.textCardReleaseCtaText,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: service.presenter.fontSizeCardCta.sp,
                      color: ConfigColor.orange)),
              Icon(Icons.arrow_forward, color: ConfigColor.orange),
              () => service.controller
                  .launchUrl(service.presenter.textCardReleaseCtaUrl)),
        ),
        onTap: () => service.controller
            .launchUrl(service.presenter.textCardReleaseCtaUrl));
  }
}
