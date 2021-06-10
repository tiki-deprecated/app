
import 'package:app/src/widgets/components/tiki_inputs/tiki_big_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../intro_screen_service.dart';

class IntroScreenButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<IntroScreenService>(context, listen: false);
    var marginTop = service.presenter.marginTopButton;
    var buttonText = service.presenter.buttonText;
    return Container(
        margin: EdgeInsets.only(top: marginTop),
        alignment: Alignment.centerLeft,
        child: TikiBigButton(
          buttonText,
          true,
          service.controller.navigateToNextScreen,
          textWidth: 65,
        ));
  }
}
