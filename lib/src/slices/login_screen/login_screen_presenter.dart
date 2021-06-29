import 'package:app/src/slices/login_screen/ui/login_screen_layout.dart';
import 'package:provider/provider.dart';

import 'login_screen_service.dart';

class LoginScreenPresenter {
  final LoginScreenService service;

  num get marginTitleTop => 5;
  num get marginCtaTop => 2;
  num get marginTitleRight => 20;
  num get marginButtonTop => 4;
  num get marginTosTop => 2;
  num get marginTextTop => 2.5;
  num get marginButtonInboxTop => 5;
  num get marginTitleInboxTop => 2;
  num get marginSkipTop => 2;
  num get marginTextRight => 10;
  num get marginResendRight => 1;
  num get marginBackArrowRight => 1;
  num get marginResendBottom => 15;
  num get marginInputTop => 2;
  num get marginHorizontal => 6;
  num get marginBackLeft => 3;

  num get fontSizeEmailTitle => 28;
  num get fontSizeEmailSubtitle => 14;
  num get fontSizeInboxTitle => 28;
  num get fontSizeSendTo => 14;
  num get fontSizeResend => 14;
  num get fontSizeBack => 15;
  num get fontSizeError => 11;
  num get fontSizeInput => 14;
  num get fontSizeTos => 10;

  num get paddingInputHorizontal => 1.5;
  num get paddingInputVertical => 2;

  get textTitle => "Hey, nice to see you here";
  get textSubtitle => "Enter your email below to begin.";
  get textInbox => "Great, now check your inbox";
  get textReceive => "Didn't receive it?";
  get textResend => "Resend now";
  get textSendTo => "I sent an email with a link to";
  get textBack => "Back";
  get textContinue => "CONTINUE";
  get textError => "Please enter a valid email";
  get textInputPlaceholder => "Your email";

  LoginScreenPresenter(this.service);

  ChangeNotifierProvider<LoginScreenService> render() {
    return ChangeNotifierProvider.value(value: service, child: LoginScreen());
  }
}
