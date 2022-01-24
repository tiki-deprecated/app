import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class KeysModalViewGenerateKeys extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 100.w,
      child:
      Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: ClipRect(
                child: Align(
                    alignment: Alignment.center,
                    heightFactor: 0.5,
                    child: Lottie.asset(
                        "res/animation/Securing_account_with_blob.json")),
              ),
            ),
          ],
        ))
      ]));
  }
}
