import 'package:flutter/material.dart';

import 'tiki_card_cta.dart';

class TikiCardRowCta extends TikiCardCta {
  final List<Widget> ctas;

  TikiCardRowCta(this.ctas);

  @override
  Widget getCta() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: ctas,
    );
  }
}
