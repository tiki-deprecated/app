import 'package:app/src/widgets/components/tiki_text/tiki_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../intro_screen_service.dart';

class IntroScreenTitle extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<IntroScreenService>(context, listen: false);
    var marginTop = service.presenter.marginTopTitle;
    var marginRight = service.presenter.marginRightText;
    return Container(
        margin:
        EdgeInsets.only(top: marginTop, right: marginRight),
        alignment: Alignment.centerLeft,
        child: TikiTitle(
          service.presenter.title,
          textAlign: TextAlign.left,
        ));
  }

}
