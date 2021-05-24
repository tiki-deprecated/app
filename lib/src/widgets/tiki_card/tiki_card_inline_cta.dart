import 'package:app/src/widgets/tiki_card/tiki_card_cta.dart';
import 'package:flutter/material.dart';

class TikiCardInlineCta extends TikiCardCta {
  final Text headline;
  final Icon trailingIcon;

  final Function? callback;

  TikiCardInlineCta(this.headline, this.trailingIcon, this.callback);

  @override
  Widget _getCta() {
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
