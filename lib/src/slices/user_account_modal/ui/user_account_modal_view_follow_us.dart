import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/helper_image.dart';
import '../../../widgets/tiki_card/tiki_card.dart';
import '../../../widgets/tiki_card/tiki_card_controller.dart';
import '../../../widgets/tiki_card/tiki_card_view_cta_grid.dart';
import '../../../widgets/tiki_card/tiki_card_view_figure.dart';
import '../../../widgets/tiki_card/tiki_card_view_text.dart';
import '../../../widgets/tiki_card/tiki_card_view_title.dart';

class UserAccountModalViewFollowUs extends StatelessWidget {
  static const num _btnPaddingHorizontal = 2;
  static const num _btnPaddingVertical = 0.75;
  static const num _btnHeight = 6;
  static const String _title = "Follow us";
  static const String _text =
      "You can find helpful and fun stuff on our channels.";
  static const String _facebookUrl = "https://www.facebook.com/mytikiapp";
  static const String _twitterUrl = "https://twitter.com/my_tiki_";
  static const String _instagramUrl = "https://www.instagram.com/my.tiki/";
  static const String _tiktokUrl = "https://www.tiktok.com/@my.tiki";

  @override
  Widget build(BuildContext context) {
    return TikiCard(
      TikiCardViewTitle(_title),
      TikiCardViewText(_text),
      TikiCardViewFigure(HelperImage("tiki-pool")),
      cta: TikiCardViewCtaGrid([
        Expanded(
            child: GestureDetector(
                onTap: () => TikiCardController.launchUrl(_facebookUrl),
                child: Container(
                    padding: EdgeInsets.only(
                        left: 3 * _btnPaddingHorizontal.w,
                        top: 3 * _btnPaddingVertical.h,
                        right: _btnPaddingHorizontal.w,
                        bottom: _btnPaddingVertical.h),
                    child:
                        HelperImage("facebook-button", height: _btnHeight.h)))),
        Expanded(
            child: GestureDetector(
                onTap: () => TikiCardController.launchUrl(_twitterUrl),
                child: Container(
                    padding: EdgeInsets.only(
                        left: _btnPaddingHorizontal.w,
                        top: 3 * _btnPaddingVertical.h,
                        right: 3 * _btnPaddingHorizontal.w,
                        bottom: _btnPaddingVertical.h),
                    child:
                        HelperImage("twitter-button", height: _btnHeight.h)))),
        Expanded(
            child: GestureDetector(
                onTap: () => TikiCardController.launchUrl(_instagramUrl),
                child: Container(
                    padding: EdgeInsets.only(
                        left: 3 * _btnPaddingHorizontal.w,
                        top: _btnPaddingVertical.h,
                        right: _btnPaddingHorizontal.w,
                        bottom: 4 * _btnPaddingVertical.h),
                    child: HelperImage("instagram-button",
                        height: _btnHeight.h)))),
        Expanded(
            child: GestureDetector(
                onTap: () => TikiCardController.launchUrl(_tiktokUrl),
                child: Container(
                    padding: EdgeInsets.only(
                        left: _btnPaddingHorizontal.w,
                        top: _btnPaddingVertical.h,
                        right: 3 * _btnPaddingHorizontal.w,
                        bottom: 4 * _btnPaddingVertical.h),
                    child:
                        HelperImage("tiktok-button", height: _btnHeight.h)))),
      ]),
    );
  }
}
