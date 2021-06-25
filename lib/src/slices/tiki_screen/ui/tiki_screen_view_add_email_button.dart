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
        margin: EdgeInsets.only(bottom: service.presenter.emailButtonMarginBottom.h),
        child: RichText(
            text: TextSpan(
                style: TextStyle(
                    fontSize: service.presenter.emailButtonFont.sp,
                    fontFamily: "NunitoSans",
                    color: Color(0xFF545454),
                    fontWeight: FontWeight.w600),
                text: "You've linked ",
                children: <InlineSpan>[
              TextSpan(
                style: TextStyle(
                    fontSize: service.presenter.emailButtonFont.sp,
                    fontFamily: "NunitoSans",
                    color: Color(0xFF545454),
                    fontWeight: FontWeight.w600),
                text: service.model.googleAccount?.email ?? "your Gmail account.",
              ),
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap =
                      () => service.controller.removeGmailAccount(context),
                style: TextStyle(
                    color: ConfigColor.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: service.presenter.emailButtonFont.sp,
                    fontFamily: "NunitoSans"),
                text: " Remove ",
              ),
              WidgetSpan(
                  alignment: ui.PlaceholderAlignment.middle,
                  child: GestureDetector(
                    onTap: () => service.controller.removeGmailAccount(context),
                    child: Container(
                        width: 16.0,
                        height: 16.0,
                        decoration: new BoxDecoration(
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(15.0)),
                          border: new Border.all(
                            color: ConfigColor.orange,
                            width: 1.0,
                          ),
                        ),
                        child: Center(
                            child: Icon(Icons.close,
                                size: 14, color: ConfigColor.orange))),
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
              width: 30,
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
              width: 35,
            ),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("See what data\nGmail has on you",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                            fontFamily: "Montserrat")))),
            HelperImage(
              "right-arrow",
              width: 30,
            )
          ]),
          onTap: () => service.controller.whatGmailHolds(context)),
    );
  }
}
