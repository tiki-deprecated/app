import 'dart:ui' as ui;

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/tiki_screen/tiki_screen_service.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TikiScreenViewAddEmailButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<TikiScreenService>(context);
    List<Widget> child = service.model.googleAccount != null
        ? [_removeRow(context, service), _seeButton(context, service)]
        : [_addButton(context, service)];
    return Column(children: child);
  }

  Widget _removeRow(context, TikiScreenService service) {
    return Container(
        margin: EdgeInsets.only(
            bottom: service.presenter.emailButtonMarginBottom.h),
        child: RichText(
            text: TextSpan(
                style: TextStyle(
                    fontSize: service.presenter.fontSizeEmail.sp,
                    fontFamily: "NunitoSans",
                    color: ConfigColor.emperor,
                    fontWeight: FontWeight.w600),
                text: "You've linked ",
                children: <InlineSpan>[
              TextSpan(
                style: TextStyle(
                    fontSize: service.presenter.fontSizeEmail.sp,
                    fontFamily: "NunitoSans",
                    color: ConfigColor.ikb,
                    fontWeight: FontWeight.w600),
                text: service.model.googleAccount?.email,
              ),
              TextSpan(
                style: TextStyle(
                    fontSize: service.presenter.fontSizeEmail.sp,
                    fontFamily: "NunitoSans",
                    color: ConfigColor.emperor,
                    fontWeight: FontWeight.w600),
                text: " as your Gmail account.",
              ),
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap =
                      () => service.controller.removeGmailAccount(context),
                style: TextStyle(
                    color: ConfigColor.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: service.presenter.fontSizeEmail.sp,
                    fontFamily: "NunitoSans"),
                text: " Remove ",
              ),
              WidgetSpan(
                  alignment: ui.PlaceholderAlignment.middle,
                  child: GestureDetector(
                    onTap: () => service.controller.removeGmailAccount(context),
                    child: Container(
                        width: 5.w,
                        height: 5.w,
                        decoration: new BoxDecoration(
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(5.w)),
                          border: new Border.all(
                            color: ConfigColor.orange,
                            width: 0.4.w,
                          ),
                        ),
                        child: Center(
                            child: Icon(Icons.close,
                                size: 12.sp, color: ConfigColor.orange))),
                  )),
            ])));
  }

  Widget _addButton(context, TikiScreenService service) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: GestureDetector(
          child: Row(children: [
            HelperImage(
              "add-email",
              width: 35,
            ),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("Add your\nGmail account",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 2.h,
                            fontFamily: "Montserrat")))),
            HelperImage(
              "right-arrow",
              width: 8.w,
            )
          ]),
          onTap: () => service.controller
              .addGmailAccount(context), //_whatGmailHolds(context)),
        ));
  }

  Widget _seeButton(context, TikiScreenService service) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: GestureDetector(
          child: Row(children: [
            HelperImage(
              "eye-added-email",
              width: 12.w,
            ),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(service.presenter.textSeeData,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: service.presenter.fontSizeSee.sp,
                            fontFamily: "Montserrat")))),
            HelperImage(
              "right-arrow",
              width: 8.w,
            )
          ]),
          onTap: () => service.controller.whatGmailHolds(context)),
    );
  }
}
