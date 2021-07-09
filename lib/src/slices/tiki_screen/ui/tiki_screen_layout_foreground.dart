import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_add_email_button.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_heading.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_logout.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_tiki_box.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_version.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../tiki_screen_service.dart';

class TikiScreenLayoutForeground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<TikiScreenService>(context, listen: false);
    return SingleChildScrollView(
        child: Stack(children: [
      Align(
          alignment: Alignment.topRight,
          child: HelperImage(
            "home-locker-tr",
            width: 55.w,
          )),
      Padding(
          padding: EdgeInsets.symmetric(
              horizontal: service.presenter.marginHorizontal.w),
          child: _content(context, service))
    ]));
  }

  Widget _content(BuildContext context, TikiScreenService service) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(top: service.presenter.marginGsTop.h),
          child: TikiScreenViewTitle(service.presenter.textGs)),
      Container(
          margin: EdgeInsets.only(top: service.presenter.marginEmailTop.h),
          child: TikiScreenViewAddEmailButton()),
      Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: service.presenter.marginUpdatesTop.h),
          child: TikiScreenViewTitle(service.presenter.textUpdates)),
      Container(
          margin: EdgeInsets.only(top: service.presenter.marginTikiBoxTop.h),
          child: TikiScreenViewTikiBox()),
      Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(top: service.presenter.marginVersionTop.h),
          child: TikiScreenViewVersion()),
      Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.symmetric(
              vertical: service.presenter.marginLogOutVertical.h),
          child: TikiScreenViewLogout())
    ]);
  }
}
