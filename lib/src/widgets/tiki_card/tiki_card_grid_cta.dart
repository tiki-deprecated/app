import 'package:flutter/material.dart';

import 'tiki_card_cta.dart';

class TikiCardGridCta extends TikiCardCta {
  final List<Widget> ctas;

  TikiCardGridCta(this.ctas);

  @override
  Widget _getCta() {
    return GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: ctas);
  }
}
