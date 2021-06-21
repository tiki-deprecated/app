import 'package:app/src/widgets/components/tiki_card/tiki_card_inline_cta.dart';
import 'package:flutter/material.dart';

import 'tiki_card_cta.dart';
import 'tiki_card_figure.dart';
import 'tiki_card_text.dart';
import 'tiki_card_title.dart';

class TikiCard extends StatelessWidget {
  final TikiCardTitle title;
  final TikiCardText text;
  final TikiCardFigure figure;
  final TikiCardCta? cta;
  final Color bgcolor;

  const TikiCard(this.title, this.text, this.figure,
      {this.cta, this.bgcolor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: bgcolor,
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
                                  Padding(padding: EdgeInsets.only(top: 10)),
                                  text,
                                ])),
                        Flexible(flex: 1, child: figure)
                      ])),
              Padding(padding: EdgeInsets.only(top: 10)),
              cta ?? Container()
            ]));
  }

  getPadding() {
    if (this.cta == null || this.cta is TikiCardInlineCta)
      return EdgeInsets.all(16);
    return EdgeInsets.only(top: 16, left: 0, right: 0, bottom: 0);
  }

  getColumnPadding() {
    if (this.cta == null || this.cta is TikiCardInlineCta)
      return EdgeInsets.all(0);
    return EdgeInsets.symmetric(horizontal: 16);
  }
}
