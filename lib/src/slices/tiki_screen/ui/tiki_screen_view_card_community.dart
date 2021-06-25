import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/tiki_screen/tiki_screen_service.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_card/tiki_card.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_card/tiki_card_cta_row.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_card/tiki_card_figure.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_card/tiki_card_text.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_card/tiki_card_title.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TikiScreenViewCardCommunity extends StatelessWidget {
  final num _btnHeight = 5;
  final num _btnIconPaddingRight = 2;
  final num _btnIconHeight = 1.5;
  final num _btnTextFontSize = 10;

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<TikiScreenService>(context);
    return TikiCard(
        TikiCardTitle(service.presenter.textCardCommunityTitle),
        TikiCardText(service.presenter.textCardCommunityText),
        TikiCardFigure(HelperImage("tiki-and-pals")),
        cta: TikiCardCtaRow([
          Expanded(
              child: GestureDetector(
                  onTap: () => service.controller
                      .launchUrl("https://discord.com/invite/evjYQq48Be"),
                  child: Container(
                    height: _btnHeight.h,
                    decoration: BoxDecoration(
                      color: ConfigColor.discordBlue,
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(24)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.only(right: _btnIconPaddingRight.w),
                          height: _btnIconHeight.h,
                          child: HelperImage("discord-logo"),
                        ),
                        Text("Discord",
                            style: TextStyle(
                                fontSize: _btnTextFontSize.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ))),
          Container(
            width: 1,
            color: ConfigColor.white,
          ),
          Expanded(
              child: GestureDetector(
                  onTap: () => service.controller.launchUrl(
                      "https://signal.group/#CjQKIA66Eq2VHecpcCd-cu-dziozMRSH3EuQdcZJNyMOYNi5EhC0coWtjWzKQ1dDKEjMqhkP"),
                  child: Container(
                      height: _btnHeight.h,
                      color: ConfigColor.signalBlue,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  right: _btnIconPaddingRight.w),
                              height: _btnIconHeight.h,
                              child: HelperImage("signal-logo"),
                            ),
                            Text("Signal",
                                style: TextStyle(
                                    fontSize: _btnTextFontSize.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))
                          ])))),
          Container(
            width: 1,
            color: ConfigColor.white,
          ),
          Expanded(
              child: GestureDetector(
                  onTap: () =>
                      service.controller.launchUrl("https://t.me/mytikiapp"),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(24)),
                        color: ConfigColor.telegramBlue,
                      ),
                      height: _btnHeight.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding:
                                EdgeInsets.only(right: _btnIconPaddingRight.w),
                            height: _btnIconHeight.h,
                            child: HelperImage("telegram-logo"),
                          ),
                          Text("Telegram",
                              style: TextStyle(
                                  fontSize: _btnTextFontSize.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))
                        ],
                      )))),
        ]));
  }
}
