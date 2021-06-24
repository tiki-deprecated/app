import 'package:app/src/slices/login_screen/login_screen_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LoginScreenViewTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<LoginScreenService>(context, listen:false);
    return Container(
        margin: EdgeInsets.only(
            top: service.presenter.marginTopTitle,
            right: service.presenter.marginRightTitle),
        alignment: Alignment.centerLeft,
        child: Text(service.presenter.title,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: 'Koara',
                fontSize: 10.sp,
                fontWeight: FontWeight.bold)));
  }
}
