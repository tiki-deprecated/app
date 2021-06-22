import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_card/tiki_card.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_card/tiki_card_figure.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_card/tiki_card_row_cta.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_card/tiki_card_text.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_card/tiki_card_title.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TikiCommunityCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TikiCard(
        TikiCardTitle("TIKI tribe"),
        TikiCardText("Join our community of TIKI-nites from around the globe."),
        TikiCardFigure(HelperImage("tiki-and-pals")),
        cta: TikiCardRowCta([
          Expanded(
              child: GestureDetector(
                  onTap: () =>
                      _launchUrl("https://discord.com/invite/evjYQq48Be"),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: ConfigColor.discordBlue,
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(24)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: 5),
                          height: 15,
                          child: HelperImage("discord-logo"),
                        ),
                        Text("Discord",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ))),
          Expanded(
              child: GestureDetector(
                  onTap: () => _launchUrl(
                      "https://signal.group/#CjQKIA66Eq2VHecpcCd-cu-dziozMRSH3EuQdcZJNyMOYNi5EhC0coWtjWzKQ1dDKEjMqhkP"),
                  child: Container(
                      height: 40,
                      color: ConfigColor.signalBlue,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 5),
                              height: 15,
                              child: HelperImage("signal-logo"),
                            ),
                            Text("Signal",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))
                          ])))),
          Expanded(
              child: GestureDetector(
                  onTap: () => _launchUrl("https://t.me/mytikiapp"),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(24)),
                        color: ConfigColor.telegramBlue,
                      ),
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 5),
                            height: 15,
                            child: HelperImage("telegram-logo"),
                          ),
                          Text("Telegram",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))
                        ],
                      )))),
        ]));
  }

  _launchUrl(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }
}
