import 'package:app/src/slices/login_screen/ui/login_screen_layout.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'login_screen_service.dart';

class LoginScreenPresenter {
  final LoginScreenService service;

  get marginTopTitle => 15;
  get marginTopCta => 2;
  get marginRightTitle => 15;
  get marginTopButton => 4;
  get marginTopTos => 2;
  get marginTopText => 2.5;
  get marginTopButtonInbox => 5;
  get marginTopTitleInbox => 15;
  get marginTopSkip => 2;
  get marginRightText => 10;
  get inboxTitleFontSize => 9;
  get sendToFontSize => 5;
  get resendFontSize => 5;
  get resendMarginRight => 1;
  get backFontSize => 5;
  get backMarginRightArrow => 1;
  get errorFontSize => 4;
  get inputPaddingHorizontal => 4;
  get inputPaddingVertical => 2;
  get inputFontSize => 5;
  get tosFontSize => 2;
  get marginTopResend => 2;
  get marginBottomResend => 25;

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
