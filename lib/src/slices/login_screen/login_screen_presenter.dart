import 'package:app/src/slices/login_screen/ui/login_screen_layout.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'login_screen_service.dart';

class LoginScreenPresenter {
  final LoginScreenService service;

  num get marginTopTitle => 15;
  num get marginTopCta => 2;
  num get marginRightTitle => 15;
  num get marginTopButton => 4;
  num get marginTopTos => 2;
  num get marginTopText => 2.5;
  num get marginTopButtonInbox => 5;
  num get marginTopTitleInbox => 15;
  num get marginTopSkip => 2;
  num get marginRightText => 10;
  num get inboxTitleFontSize => 9;
  num get sendToFontSize => 5;
  num get resendFontSize => 5;
  num get resendMarginRight => 1;
  num get backFontSize => 5;
  num get backMarginRightArrow => 1;
  num get errorFontSize => 4;
  num get inputPaddingHorizontal => 4;
  num get inputPaddingVertical => 2;
  num get inputFontSize => 5;
  num get tosFontSize => 2;
  num get marginTopResend => 2;
  num get marginBottomResend => 25;

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

  get marginTopInput => 2.5.h;

  ChangeNotifierProvider<LoginScreenService> render() {
    return ChangeNotifierProvider.value(value: service, child: LoginScreen());
  }
}
