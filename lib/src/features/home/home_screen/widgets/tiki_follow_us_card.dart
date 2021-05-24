import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/widgets/components/tiki_card/tiki_card.dart';
import 'package:app/src/widgets/components/tiki_card/tiki_card_figure.dart';
import 'package:app/src/widgets/components/tiki_card/tiki_card_grid_cta.dart';
import 'package:app/src/widgets/components/tiki_card/tiki_card_text.dart';
import 'package:app/src/widgets/components/tiki_card/tiki_card_title.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TikiFollowUsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TikiCard(
      TikiCardTitle("Follow us"),
      TikiCardText("Follow TIKI on social - you never know they'll do."),
      TikiCardFigure(HelperImage("tiki-pool")),
      cta: TikiCardGridCta([
        Expanded(
            child: GestureDetector(
                onTap: () => _launchUrl("https://www.facebook.com/mytikiapp"),
                child: Container(
                    padding:
                        EdgeInsets.only(left: 16, top: 16, right: 8, bottom: 8),
                    child: HelperImage("facebook-button")))),
        Expanded(
            child: GestureDetector(
                onTap: () => _launchUrl("https://twitter.com/my_tiki_"),
                child: Container(
                    padding:
                        EdgeInsets.only(left: 8, top: 16, right: 16, bottom: 8),
                    child: HelperImage("twitter-button")))),
        Expanded(
            child: GestureDetector(
                onTap: () => _launchUrl("https://www.instagram.com/my.tiki/"),
                child: Container(
                    padding:
                        EdgeInsets.only(left: 16, top: 8, right: 8, bottom: 16),
                    child: HelperImage("instagram-button")))),
        Expanded(
            child: GestureDetector(
                onTap: () => _launchUrl("https://www.tiktok.com/@my.tiki?"),
                child: Container(
                    padding:
                        EdgeInsets.only(left: 8, top: 8, right: 16, bottom: 16),
                    child: HelperImage("tiktok-button")))),
      ]),
    );
  }

  _launchUrl(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }
}
