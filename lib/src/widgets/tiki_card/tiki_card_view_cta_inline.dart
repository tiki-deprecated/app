import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
        padding: EdgeInsets.only(left: 1.w),
        alignment: Alignment.centerLeft,
        icon: trailingIcon,
        onPressed: () => callback!(),
      )
    ]);
  }
}
