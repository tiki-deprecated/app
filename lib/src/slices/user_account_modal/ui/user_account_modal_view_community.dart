import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:app/src/widgets/tiki_card/tiki_card_controller.dart';
import 'package:app/src/widgets/tiki_card/tiki_card_layout.dart';
import 'package:app/src/widgets/tiki_card/tiki_card_view_cta_row.dart';
import 'package:app/src/widgets/tiki_card/tiki_card_view_figure.dart';
import 'package:app/src/widgets/tiki_card/tiki_card_view_text.dart';
import 'package:app/src/widgets/tiki_card/tiki_card_view_title.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UserAccountModalViewCommunity extends StatelessWidget {
  static const num _btnHeight = 5;
  static const num _btnIconPaddingRight = 2;
  static const num _btnIconHeight = 1.5;
  static const num _btnTextFontSize = 10;
  static const String _title = "TIKI tribe";
  static const String _text =
      "Join our community of \nTIKI-nites from around \nthe globe.";
  static const String _discord = "Discord";
  static const String _discordLink = "https://discord.com/invite/evjYQq48Be";
  static const Color _discordColor = Color(0xFF7289DA);
  static const String _signal = "Signal";
  static const String _signalLink =
      "https://signal.group/#CjQKIA66Eq2VHecpcCd-cu-dziozMRSH3EuQdcZJNyMOYNi5EhC0coWtjWzKQ1dDKEjMqhkP";
  static const Color _signalColor = Color(0xFF3661D1);
  static const String _telegram = "Telegram";
  static const String _telegramLink = "https://t.me/mytikiapp";
  static const Color _telegramColor = Color(0xFF0088CC);

  @override
  Widget build(BuildContext context) {
    return TikiCardLayout(TikiCardViewTitle(_title), TikiCardViewText(_text),
        TikiCardViewFigure(HelperImage("tiki-and-pals")),
        cta: TikiCardViewCtaRow([
          Expanded(
              child: GestureDetector(
                  onTap: () => TikiCardController.launchUrl(_discordLink),
                  child: Container(
                      height: _btnHeight.h,
                      decoration: BoxDecoration(
                          color: _discordColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(24))),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                padding: EdgeInsets.only(
                                    right: _btnIconPaddingRight.w),
                                height: _btnIconHeight.h,
                                child: HelperImage("discord-logo")),
                            Text(_discord,
                                style: TextStyle(
                                    fontSize: _btnTextFontSize.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))
                          ])))),
          Container(width: 1, color: ConfigColor.white),
          Expanded(
              child: GestureDetector(
                  onTap: () => TikiCardController.launchUrl(_signalLink),
                  child: Container(
                      height: _btnHeight.h,
                      color: _signalColor,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  right: _btnIconPaddingRight.w),
                              height: _btnIconHeight.h,
                              child: HelperImage("signal-logo"),
                            ),
                            Text(_signal,
                                style: TextStyle(
                                    fontSize: _btnTextFontSize.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))
                          ])))),
          Container(width: 1, color: ConfigColor.white),
          Expanded(
              child: GestureDetector(
                  onTap: () => TikiCardController.launchUrl(_telegramLink),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(24)),
                          color: _telegramColor),
                      height: _btnHeight.h,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                padding: EdgeInsets.only(
                                    right: _btnIconPaddingRight.w),
                                height: _btnIconHeight.h,
                                child: HelperImage("telegram-logo")),
                            Text(_telegram,
                                style: TextStyle(
                                    fontSize: _btnTextFontSize.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))
                          ])))),
        ]));
  }
}
