import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'tiki_card_view_cta.dart';

class TikiCardViewCtaRow extends TikiCardViewCta {
  final List<Widget> ctas;

  TikiCardViewCtaRow(this.ctas);

  @override
  Widget getCta() {
    return Container(
        padding: EdgeInsets.only(top: 2.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: ctas,
        ));
  }
}
