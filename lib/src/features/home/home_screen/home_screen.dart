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
                "For latest news and updates,\ncheck out our Medium blog."),
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
                  "Join our community of\nTIKI-nites from around\nthe globe."),
              TikiCardFigure(HelperImage("tiki-and-pals")),
              cta: TikiCardRowCta([
                Container(
                  color: ConfigColor.discordBlue,
                  child: Row(
                    children: [
                      HelperImage("discord-logo"),
                      Text("Discord",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                Container(
                    color: ConfigColor.signalBlue,
                    child: Row(children: [
                      HelperImage("signal-logo"),
                      Text("Signal",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold))
                    ])),
                Container(
                    color: ConfigColor.telegramBlue,
                    child: Row(
                      children: [
                        HelperImage("telegram-logo"),
                        Text("Telegram",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))
                      ],
                    )),
              ]))),
      Container(
          margin: EdgeInsets.only(top: _marginTopCards),
          alignment: Alignment.topCenter,
          child: TikiCard(
            TikiCardTitle("Follow us"),
            TikiCardText("Follow TIKI on social - you\nnever know they'll do."),
            TikiCardFigure(HelperImage("tiki-pool")),
            cta: TikiCardInlineCta(
                Text("Read More"), Icon(Icons.arrow_forward), () => {}),
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
