import 'package:app/src/slices/md_viewer/md_viewer_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_screen_service.dart';

class LoginScreenController {
  submitLogin(BuildContext context) {
    Provider.of<LoginScreenService>(context, listen: false)
        .submitEmail(context);
  }

  emailChanged(BuildContext context, String input) {
    Provider.of<LoginScreenService>(context, listen: false)
        .onEmailChange(input);
  }

  back(BuildContext context) {
    Provider.of<LoginScreenService>(context, listen: false).back();
  }

  resend(BuildContext context) {
    Provider.of<LoginScreenService>(context, listen: false).resend(context);
  }

  tos(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MdViewerService("TERMS").getUI()));
  }

  privacy(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MdViewerService("PRIVACY").getUI()));
  }
}
