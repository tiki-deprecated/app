import 'package:app/src/slices/login_screen/ui/login_screen_layout.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'login_screen_service.dart';

class LoginScreenPresenter {
  final LoginScreenService service;

  get title => "Hey, nice to see you here";
  get subtitle => "Enter your email below to begin.";


  get marginTopTitle => 15.h;
  get marginTopCta => 2.h;
  get marginRightTitle => 15.w;
  get marginTopButton => 4.h;
  get marginTopTos => 2.h;
  final double marginTopText = 2.5.h;
  final double marginTopButtonInbox = 5.h;
  final double marginTopTitleInbox = 15.h;
  final double marginTopSkip = 2.h;
  final double marginRightText = 10.h;

  LoginScreenPresenter(this.service);

  get marginTopInput => 2.5.h;

  ChangeNotifierProvider<LoginScreenService> render() {
    return ChangeNotifierProvider.value(value: service, child: LoginScreen());
  }
}
