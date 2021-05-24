/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/features/home/home_counter/bloc/home_counter_cubit.dart';
import 'package:app/src/features/home/home_screen/widgets/home_screen_counter.dart';
import 'package:app/src/features/home/home_screen/widgets/home_screen_refer.dart';
import 'package:app/src/features/home/home_screen/widgets/home_screen_share.dart';
import 'package:app/src/features/home/home_screen/widgets/home_screen_title.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:app/src/widgets/components/tiki_card/tiki_card.dart';
import 'package:app/src/widgets/components/tiki_card/tiki_card_figure.dart';
import 'package:app/src/widgets/components/tiki_card/tiki_card_grid_cta.dart';
import 'package:app/src/widgets/components/tiki_card/tiki_card_inline_cta.dart';
import 'package:app/src/widgets/components/tiki_card/tiki_card_row_cta.dart';
import 'package:app/src/widgets/components/tiki_card/tiki_card_text.dart';
import 'package:app/src/widgets/components/tiki_card/tiki_card_title.dart';
import 'package:app/src/widgets/screens/tiki_background.dart';
import 'package:app/src/widgets/screens/tiki_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/home_screen_logout.dart';

class HomeScreen extends StatelessWidget {
  static final double _marginTopTitle = 20 * PlatformRelativeSize.blockVertical;
  static final double _marginTopCount = 8 * PlatformRelativeSize.blockVertical;
  static final double _marginTopRefer = 8 * PlatformRelativeSize.blockVertical;
  static final double _marginTopShare = 8 * PlatformRelativeSize.blockVertical;
  static final double _marginTopCards = 2 * PlatformRelativeSize.blockVertical;
  static final double _marginBottomLogOut =
      4 * PlatformRelativeSize.blockVertical;

  Widget _background() {
    return TikiBackground(
      backgroundColor: ConfigColor.serenade,
      topRight: HelperImage("home-blob-tr"),
      bottomRight: HelperImage("home-pineapple"),
    );
  }

  List<Widget> _foreground(BuildContext context) {
    return [
      Container(
          margin: EdgeInsets.only(top: _marginTopTitle),
          alignment: Alignment.center,
          child: HomeScreenTitle()),
      Container(
          margin: EdgeInsets.only(top: _marginTopCount),
          child: BlocProvider(
            create: (BuildContext context) => HomeCounterCubit.provide(context),
            child: HomeScreenCounter(),
          )),
      Container(
          margin: EdgeInsets.only(top: _marginTopRefer),
          child: HomeScreenRefer()),
      Container(
          margin: EdgeInsets.only(top: _marginTopShare),
          alignment: Alignment.topCenter,
          child: HomeScreenShare()),
      Container(
          margin: EdgeInsets.only(top: _marginTopCards),
          alignment: Alignment.topCenter,
          child: TikiCard(
            TikiCardTitle("Coming next"),
            TikiCardText("TIKI's next release:\nadd your Gmail account"),
            TikiCardFigure(HelperImage("tiki-news")),
            cta: TikiCardInlineCta(
                Text("Read More",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: PlatformRelativeSize.blockHorizontal * 4,
                        color: ConfigColor.orange)),
                Icon(Icons.arrow_forward, color: ConfigColor.orange),
                () => {}),
          )),
      Container(
          margin: EdgeInsets.only(top: _marginTopCards),
          alignment: Alignment.topCenter,
          child: TikiCard(
            TikiCardTitle("Latest News"),
            TikiCardText(
                "For latest news and updates, check out our Medium blog."),
            TikiCardFigure(HelperImage("tiki-news")),
            cta: TikiCardInlineCta(
                Text("Read More",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: PlatformRelativeSize.blockHorizontal * 4,
                        color: ConfigColor.orange)),
                Icon(Icons.arrow_forward, color: ConfigColor.orange),
                () => {}),
          )),
      Container(
          margin: EdgeInsets.only(top: _marginTopCards),
          alignment: Alignment.topCenter,
          child: TikiCard(
              TikiCardTitle("TIKI tribe"),
              TikiCardText(
                  "Join our community of TIKI-nites from around the globe."),
              TikiCardFigure(HelperImage("tiki-and-pals")),
              cta: TikiCardRowCta([
                Expanded(
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
                              color: Colors.white, fontWeight: FontWeight.bold))
                    ],
                  ),
                )),
                Expanded(
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
                            ]))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(24)),
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
                        ))),
              ]))),
      Container(
          margin: EdgeInsets.only(top: _marginTopCards),
          alignment: Alignment.topCenter,
          child: TikiCard(
            TikiCardTitle("Follow us"),
            TikiCardText("Follow TIKI on social - you never know they'll do."),
            TikiCardFigure(HelperImage("tiki-pool")),
            cta: TikiCardGridCta([
              Expanded(
                  child: Container(
                      padding: EdgeInsets.only(left: 16, top:16, right: 8, bottom:8),
                      child: HelperImage("facebook-button"))),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.only(left: 8, top:16, right: 16, bottom:8),
                      child: HelperImage("tiktok-button"))),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.only(left: 16, top:8, right: 8, bottom:16),
                      child: HelperImage("twitter-button"))),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.only(left: 8, top:8, right: 16, bottom:16),
                      child: HelperImage("instagram-button"))),
            ]),
          )),
      Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(bottom: _marginBottomLogOut),
          child: HomeScreenLogout()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return TikiScaffold(
        foregroundChildren: _foreground(context),
        background: _background() as TikiBackground?);
  }
}
