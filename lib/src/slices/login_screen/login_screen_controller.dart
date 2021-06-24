import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_screen_service.dart';

class LoginScreenController {
  submitLogin(BuildContext context) {
    Provider.of<LoginScreenService>(context, listen: false).submitEmail(context);
  }

  emailChanged(BuildContext context, String input) {
    Provider.of<LoginScreenService>(context, listen: false).onEmailChange(input);
  }

  back(BuildContext context) {
    Provider.of<LoginScreenService>(context, listen: false).back();
  }
}
