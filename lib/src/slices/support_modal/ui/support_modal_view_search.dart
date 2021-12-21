import 'package:app/src/config/config_color.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SupportModalSearch extends StatelessWidget {
  static const String _text = "Search for answers...";
  static const num _paddingVert = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(
          top: _paddingVert.h,
        ),
        child: TextField(
            style: TextStyle(fontSize: 12.sp, color: ConfigColor.tikiBlue),
            cursorColor: ConfigColor.tikiBlue,
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(20.0),
                prefixIcon: Icon(Icons.search, color: ConfigColor.tikiPurple, size: 30),
                hintText: _text,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(3.w),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(3.w),
                )
            )
        ));
  }
}
