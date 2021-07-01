import 'package:app/src/slices/login_screen/login_screen_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LoginScreenViewTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<LoginScreenService>(context);
    return Text(service.presenter.textTitle,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontFamily: 'Koara',
            fontSize: service.presenter.fontSizeEmailTitle.sp,
            fontWeight: FontWeight.bold));
  }
}
