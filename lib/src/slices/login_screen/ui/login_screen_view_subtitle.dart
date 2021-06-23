import 'package:app/src/slices/login_screen/login_screen_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LoginScreenViewSubtitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<LoginScreenService>(context);
    return Container(
        margin: EdgeInsets.only(top: service.presenter.marginTopCta),
        alignment: Alignment.centerLeft,
        child: Text(service.presenter.subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 5.w, fontWeight: FontWeight.w600)));
  }
}
