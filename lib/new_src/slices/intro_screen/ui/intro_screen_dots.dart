
import 'package:app/src/widgets/components/tiki_dots.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../intro_screen_service.dart';

class IntroScreenDots extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<IntroScreenService>(context, listen: false);
    var marginTop = service.presenter.marginTopText;
    var marginRight = service.presenter.marginRightText;
    return Container(
        margin: EdgeInsets.only(top: marginTop, right: marginRight),
        alignment: Alignment.centerLeft,
        child: TikiDots(
            service.model.getTotalSlides(),
            service.model.getCurrentSlideIndex()));
  }

}
