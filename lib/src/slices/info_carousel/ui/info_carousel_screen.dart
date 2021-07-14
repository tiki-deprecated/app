import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/info_carousel/ui/info_carousel_view_close.dart';
import 'package:app/src/slices/info_carousel/ui/info_carousel_view_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class InfoCarouselScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(builder: (BuildContext context) {
      return Container(
          color: ConfigColor.greyTwo,
          child: SafeArea(
              child: Container(
                  child: Column(children: [
            Padding(
                padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                child: InfoCarouselViewClose()),
            Expanded(child: InfoCarouselViewSlider())
          ]))));
    }));
  }
}
