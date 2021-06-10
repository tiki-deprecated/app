import 'package:app/new_src/slices/intro_screen/intro_screen_service.dart';
import 'package:app/src/widgets/components/tiki_inputs/tiki_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class IntroScreenSkipButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<IntroScreenService>(context, listen: false);
    var text = service.presenter.skipText;
    var marginTop = service.presenter.marginTopSkip;
    return Container(
        margin: EdgeInsets.only(top: marginTop),
        alignment: Alignment.topRight,
        child: TikiTextButton(
          text,
          service.controller.skipToLogin,
          fontWeight: FontWeight.bold,
          fontSize: 4,
        ));
  }
}