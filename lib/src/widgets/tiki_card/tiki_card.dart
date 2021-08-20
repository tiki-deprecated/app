import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../config/config_color.dart';
import 'tiki_card_view_cta.dart';
import 'tiki_card_view_cta_inline.dart';
import 'tiki_card_view_figure.dart';
import 'tiki_card_view_text.dart';
import 'tiki_card_view_title.dart';

class TikiCard extends StatelessWidget {
  final TikiCardViewTitle title;
  final TikiCardViewText text;
  final TikiCardViewFigure figure;
  final TikiCardViewCta? cta;
  final Color bgColor;

  const TikiCard(this.title, this.text, this.figure,
      {this.cta, this.bgColor = ConfigColor.greyTwo});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(24),
        ),
        padding: getPadding(),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                  padding: getColumnPadding(),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                            flex: 2,
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  title,
                                  Container(
                                      margin: EdgeInsets.only(top: 0.75.h),
                                      child: text),
                                ])),
                        Flexible(
                          flex: 1,
                          child: figure,
                        )
                      ])),
              cta ?? Container()
            ]));
  }

  getPadding() {
    if (this.cta == null || this.cta is TikiCardViewCtaInline)
      return EdgeInsets.only(top: 2.h, left: 6.w, right: 6.w, bottom: 1.h);
    return EdgeInsets.only(top: 3.h, left: 0, right: 0, bottom: 0);
  }

  getColumnPadding() {
    if (this.cta == null || this.cta is TikiCardViewCtaInline)
      return EdgeInsets.all(0);
    return EdgeInsets.symmetric(horizontal: 6.w);
  }
}
