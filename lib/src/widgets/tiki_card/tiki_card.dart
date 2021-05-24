import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'tiki_card_cta.dart';
import 'tiki_card_figure.dart';
import 'tiki_card_text.dart';
import 'tiki_card_title.dart';

class TikiCard extends StatelessWidget {
  final TikiCardTitle title;
  final TikiCardText text;
  final TikiCardFigure figure;
  final TikiCardCta cta;
  final Color bgcolor;

  const TikiCard(this.title, this.text, this.figure,
      {this.cta, this.bgcolor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(

        decoration: BoxDecoration(
            color: bgcolor,
            borderRadius: BorderRadius.circular(24)),
        padding: EdgeInsets.all(16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          title,
                          text,
                        ]),
                    figure
                  ]),
              cta ?? Container()
            ]));
  }
}
