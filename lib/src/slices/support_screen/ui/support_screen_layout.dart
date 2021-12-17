/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../api_zendesk/model/api_zendesk_article.dart';
import '../../api_zendesk/model/api_zendesk_category.dart';
import '../../api_zendesk/model/api_zendesk_section.dart';

import 'support_screen_view_box.dart';
import 'support_screen_view_hi_there.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'support_screen_view_breadcrumb.dart';
import 'support_screen_view_header.dart';

class SupportScreenLayout extends StatelessWidget {
  final dynamic data;

  const SupportScreenLayout(this.data);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
            height: 85.h,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              SupporScreenViewHeader(),
              Expanded(
                  child: SingleChildScrollView(
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 6.w, right: 6.w, bottom: 5.h),
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            SupportScreenViewHiThere(),
                            SupportScreenViewBreadcrumb(),
                            Container(
                                child: getSupportContent(context)),
                          ]))))
            ])));
  }

  Widget getSupportContent(BuildContext context) {
    if( data == null)
      return CircularProgressIndicator();
    if( data is List<ApiZendeskCategory> ||
        data is List<ApiZendeskSection> ||
        data is List<ApiZendeskArticle> )
        return Column(
            children: data.children
                .map((data) => SupportScreenViewBox(data)));
    return SupportScreenViewBox(data);
  }
}
