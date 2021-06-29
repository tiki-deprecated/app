import 'package:app/src/slices/info_card/ui/info_card_layout_container.dart';
import 'package:flutter/material.dart';

class InfoCardLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return InfoCardLayoutContainer(constraints);
        }));
  }
}
