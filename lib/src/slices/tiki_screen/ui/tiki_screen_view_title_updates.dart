import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_title.dart';
import 'package:flutter/material.dart';

class TikiScreenViewTitleUpdates extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        child:
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              margin: EdgeInsets.only(top: 50, bottom: 20),
              child: TikiScreenViewTitle("TIKI updates"))
        ]));
  }
}