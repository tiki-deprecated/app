import 'package:flutter/material.dart';

import 'tiki_card_view_cta.dart';

class TikiCardViewCtaInline extends TikiCardViewCta {
  final Text headline;
  final Icon trailingIcon;

  final Function? callback;

  TikiCardViewCtaInline(this.headline, this.trailingIcon, this.callback);

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
