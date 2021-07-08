import 'package:flutter/material.dart';

import 'tiki_card_view_cta.dart';

class TikiCardViewCtaRow extends TikiCardViewCta {
  final List<Widget> ctas;

  TikiCardViewCtaRow(this.ctas);

  @override
  Widget getCta() {
    return Container(
        padding: EdgeInsets.only(top: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: ctas,
        ));
  }
}
