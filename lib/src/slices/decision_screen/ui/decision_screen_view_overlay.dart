import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DecisionScreenViewOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This makes sure that text and other content follows the material style
    return Material(
        type: MaterialType.transparency, child: _buildOverlayContent(context));
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          HelperImage("overlay-bg"),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 20.h)),
              HelperImage("swipe-choices"),
              Padding(padding: EdgeInsets.only(top: 4.h)),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text:
                          "Unsubscribe from an email list by swiping left, or\nkeep their emails coming by swiping right.\n\n",
                      style: TextStyle(fontSize: 12.sp),
                      children: [
                        TextSpan(
                            text:
                                "Unsubscribing will remove you from an email list.\n",
                            style: TextStyle(color: ConfigColor.tikiOrange)),
                        TextSpan(
                            text:
                                "You can always re-subscribe by going back to\ntheir website.")
                      ]))
            ],
          ),
        ]));
  }
}
