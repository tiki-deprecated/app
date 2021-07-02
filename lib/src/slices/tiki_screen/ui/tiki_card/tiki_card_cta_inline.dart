import 'package:app/src/slices/tiki_screen/ui/tiki_card/tiki_card_cta.dart';
import 'package:flutter/material.dart';

class TikiCardCtaInline extends TikiCardCta {
  final Text headline;
  final Icon trailingIcon;

  final Function? callback;

  TikiCardCtaInline(this.headline, this.trailingIcon, this.callback);

  @override
  Widget getCta() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      headline,
      IconButton(
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
        icon: trailingIcon,
        onPressed: () => callback!(),
      )
    ]);
  }
}
