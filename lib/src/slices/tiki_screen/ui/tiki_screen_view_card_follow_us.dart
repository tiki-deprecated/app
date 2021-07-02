import 'package:app/src/slices/tiki_screen/tiki_screen_service.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_card/tiki_card.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_card/tiki_card_cta_grid.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_card/tiki_card_figure.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_card/tiki_card_text.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_card/tiki_card_title.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TikiScreenViewCardFollowUs extends StatelessWidget {
  final num _btnPaddingHorizontal = 2;
  final num _btnPaddingVertical = 0.75;
  final num _btnHeight = 6;

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<TikiScreenService>(context);
    return TikiCard(
      TikiCardTitle(service.presenter.textCardFollowTitle),
      TikiCardText(service.presenter.textCardFollowText),
      TikiCardFigure(HelperImage("tiki-pool")),
      cta: TikiCardCtaGrid([
        Expanded(
            child: GestureDetector(
                onTap: () => service.controller
                    .launchUrl("https://www.facebook.com/mytikiapp"),
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
                onTap: () => service.controller
                    .launchUrl("https://twitter.com/my_tiki_"),
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
                onTap: () => service.controller
                    .launchUrl("https://www.instagram.com/my.tiki/"),
                child: Container(
                    padding: EdgeInsets.only(
                        left: 3 * _btnPaddingHorizontal.w,
                        top: _btnPaddingVertical.h,
                        right: _btnPaddingHorizontal.w,
                        bottom: 8 * _btnPaddingVertical.h),
                    child: HelperImage("instagram-button",
                        height: _btnHeight.h)))),
        Expanded(
            child: GestureDetector(
                onTap: () => service.controller
                    .launchUrl("https://www.tiktok.com/@my.tiki?"),
                child: Container(
                    padding: EdgeInsets.only(
                        left: _btnPaddingHorizontal.w,
                        top: _btnPaddingVertical.h,
                        right: 3 * _btnPaddingHorizontal.w,
                        bottom: 8 * _btnPaddingVertical.h),
                    child:
                        HelperImage("tiktok-button", height: _btnHeight.h)))),
      ]),
    );
  }
}
