import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_title.dart';
import 'package:flutter/material.dart';

class TikiScreenViewTitleGs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: 140, bottom: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Container(child: TikiScreenViewTitle("Get started"))]));
  }
}
