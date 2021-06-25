import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_add_email_button.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_heading.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_tiki_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../tiki_screen_service.dart';

class TikiScreenLayoutForeground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<TikiScreenService>(context, listen: false);
    return SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: service.presenter.marginHorizontal.w),
            child:
                SingleChildScrollView(child: _foreground(context, service))));
  }

  Widget _foreground(BuildContext context, TikiScreenService service) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
          alignment: Alignment.centerLeft,
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
      //TikiScreenViewNextReleaseCard(),
      //TikiScreenViewNewsCard(),
      //TikiScreenViewCommunityCard(),
      //TikiScreenViewFollowUsCard(),
      //TikiScreenViewLogout(),
      //TikiScreenViewVersion(),
    ]);
  }
}
