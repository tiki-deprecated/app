import 'package:app/src/slices/login_screen/ui/login_screen_layout.dart';
import 'package:provider/provider.dart';

import 'login_screen_service.dart';

class LoginScreenPresenter {
  final LoginScreenService service;

  num get marginTopTitle => 5;
  num get marginTopCta => 2;
  num get marginRightTitle => 20;
  num get marginTopButton => 4;
  num get marginTopTos => 2;
  num get marginTopText => 2.5;
  num get marginTopButtonInbox => 5;
  num get marginTopTitleInbox => 2;
  num get marginTopSkip => 2;
  num get marginRightText => 10;
  num get resendMarginRight => 1;
  num get backMarginRightArrow => 1;
  num get marginBottomResend => 15;
  num get marginTopInput => 2;
  num get marginHorizontal => 6;
  num get marginLeftBack => 3;

  num get emailTitleFontSize => 28;
  num get emailSubtitleFontSize => 14;
  num get inboxTitleFontSize => 28;
  num get sendToFontSize => 14;
  num get resendFontSize => 14;
  num get backFontSize => 15;
  num get errorFontSize => 11;
  num get inputFontSize => 14;
  num get tosFontSize => 10;

  num get inputPaddingHorizontal => 1.5;
  num get inputPaddingVertical => 2;

  get title => "Hey, nice to see you here";
  get subtitle => "Enter your email below to begin.";
  get inboxText => "Great, now check your inbox";
  get receiveText => "Didn't receive it?";
  get resendText => "Resend now";
  get sendToText => "I sent an email with a link to";
  get backText => "Back";
  get continueText => "CONTINUE";
  get errorText => "Please enter a valid email";
  get inputPlaceholder => "Your email";

  LoginScreenPresenter(this.service);

  ChangeNotifierProvider<LoginScreenService> render() {
    return ChangeNotifierProvider.value(value: service, child: LoginScreen());
  }
}
