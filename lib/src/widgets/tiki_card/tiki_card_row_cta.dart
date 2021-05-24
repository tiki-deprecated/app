import 'package:flutter/material.dart';

import 'tiki_card_cta.dart';

class TikiCardRowCta extends TikiCardCta {
  final List<Widget> ctas;

  TikiCardRowCta(this.ctas);

  @override
  Widget _getCta() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: ctas,
    );
  }
}
