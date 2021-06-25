import 'package:flutter/material.dart';

import 'tiki_card_cta.dart';

class TikiCardCtaGrid extends TikiCardCta {
  final List<Widget> ctas;

  TikiCardCtaGrid(this.ctas);

  Widget buildGrid() {
    return Column(
      children: [
        Row(
          children: [ctas[0], ctas[1]],
        ),
        Row(
          children: [ctas[2], ctas[3]],
        )
      ],
    );
  }

  @override
  Widget getCta() {
    return Container(child: buildGrid());
  }
}
