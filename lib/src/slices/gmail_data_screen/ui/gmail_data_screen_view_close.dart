import 'package:app/src/slices/gmail_data_screen/gmail_data_screen_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class GmailDataScreenViewClose extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var presenter = Provider.of<GmailDataScreenService>(context).presenter;
    return GestureDetector(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('CLOSE ',
              style: TextStyle(
                  fontSize: presenter.closeFontSize.sp,
                  color: presenter.closeColor,
                  fontFamily: "NunitoSans",
                  fontWeight: FontWeight.w900)),
          Icon(Icons.close,
              size: presenter.closeIconFontSize.sp,
              color: presenter.closeColor),
        ]),
        onTap: () => Navigator.of(context).pop());
  }
}
