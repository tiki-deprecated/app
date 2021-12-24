/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../api_zendesk/model/api_zendesk_article.dart';
import '../../api_zendesk/model/api_zendesk_category.dart';
import '../../api_zendesk/model/api_zendesk_section.dart';
import '../support_modal_service.dart';
import 'support_modal_view_box.dart';
import 'support_modal_view_breadcrumb.dart';
import 'support_modal_view_header.dart';
import 'support_modal_view_hi_there.dart';

class SupportModalLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
            height: 85.h,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              SupportModalViewHeader(),
              Expanded(
                  child: SingleChildScrollView(
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 6.w, right: 6.w, bottom: 5.h),
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            SupportModalViewHiThere(),
                            //SupportModalSearch(),
                            SupportModalViewBreadcrumb(),
                            Container(child: _getSupportContent(context)),
                          ]))))
            ])));
  }

  Widget _getSupportContent(BuildContext context) {
    SupportModalService service = Provider.of<SupportModalService>(context);
    if (service.data == null)
      return Container(
          padding: EdgeInsets.only(top: 5.h),
          child: CircularProgressIndicator());
    if (service.data is List<ApiZendeskCategory> ||
        service.data is List<ApiZendeskSection> ||
        service.data is List<ApiZendeskArticle>)
      return Column(children: _getViewBoxList(service.data));
    return SupportModalViewBox(service.data, excerpt: false);
  }

  List<Widget> _getViewBoxList(dynamic data) {
    List<Widget> viewBoxList = [];
    data.forEach((el) => viewBoxList.add(SupportModalViewBox(el)));
    return viewBoxList;
  }
}
