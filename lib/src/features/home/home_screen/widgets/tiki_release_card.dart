import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:app/src/widgets/components/tiki_card/tiki_card.dart';
import 'package:app/src/widgets/components/tiki_card/tiki_card_figure.dart';
import 'package:app/src/widgets/components/tiki_card/tiki_card_inline_cta.dart';
import 'package:app/src/widgets/components/tiki_card/tiki_card_text.dart';
import 'package:app/src/widgets/components/tiki_card/tiki_card_title.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TikiNextReleaseCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TikiCard(
      TikiCardTitle("Coming next"),
      TikiCardText("TIKI's next release:\nadd your Gmail account"),
      TikiCardFigure(HelperImage("add-gmail")),
      cta: TikiCardInlineCta(
          Text("Read More",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: PlatformRelativeSize.blockHorizontal * 4,
                  color: ConfigColor.orange)),
          Icon(Icons.arrow_forward, color: ConfigColor.orange),
          () => _launchUrl("https://mytiki.com/roadmap")),
    );
  }

  _launchUrl(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }
}
