import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/tiki_screen/tiki_screen_service.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_card/tiki_card.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_card/tiki_card_figure.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_card/tiki_card_inline_cta.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_card/tiki_card_text.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_card/tiki_card_title.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class TikiNextReleaseCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<TikiScreenService>(context);
    return GestureDetector(
        child: TikiCard(
          TikiCardTitle("Coming next"),
          TikiCardText("TIKI's next release:\nadd your Gmail account"),
          TikiCardFigure(HelperImage("add-gmail")),
          cta: TikiCardInlineCta(
              Text("Read More",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 4.w,
                      color: ConfigColor.orange)),
              Icon(Icons.arrow_forward, color: ConfigColor.orange),
              () => service.controller.launchUrl("https://mytiki.com/roadmap")),
        ),
        onTap: () => service.controller.launchUrl("https://mytiki.com/roadmap"));
  }

}
