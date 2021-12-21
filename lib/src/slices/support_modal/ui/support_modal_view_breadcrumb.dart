import 'package:app/src/config/config_font.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../../api_zendesk/model/api_zendesk_article.dart';
import '../../api_zendesk/model/api_zendesk_category.dart';
import '../../api_zendesk/model/api_zendesk_section.dart';
import '../support_modal_service.dart';

class SupportModalViewBreadcrumb extends StatelessWidget {
  final String catText =
      "Welcome to our Help Center. Search for an\nanswer or check out our articles below.";
  final String separator = " > ";
  final Color catColor = ConfigColor.tikiBlue;
  final Color defaultColor = ConfigColor.greyFive;

  @override
  Widget build(BuildContext context) {
    SupportModalService service = Provider.of<SupportModalService>(context);
    String text = _getBreadcrumbText(service);
    return Container(
        padding: EdgeInsets.only(top:3.h),
        alignment: Alignment.centerLeft,
        child:
        Text(text,
        style: TextStyle(
            color: service.data == null || service.data is List<ApiZendeskCategory>
                ? this.catColor
                : this.defaultColor,
            fontFamily: ConfigFont.familyNunitoSans,
            fontWeight: FontWeight.w600,
            fontSize: 11.sp
            ),
        textAlign: TextAlign.start
    ));
  }

  String _getBreadcrumbText(SupportModalService service) {
    String leadText = "All categories";
    if (service.data is List<ApiZendeskCategory>) {
      ApiZendeskCategory category = service.data as ApiZendeskCategory;
      return leadText + separator + category.title;
    }
    if (service.data is List<ApiZendeskSection>) {
      ApiZendeskSection section = service.data as ApiZendeskSection;
      return leadText +
          separator +
          section.category +
          separator +
          section.title;
    }
    if (service.data is ApiZendeskArticle ||
        service.data is List<ApiZendeskArticle>) {
      ApiZendeskArticle article = service.data as ApiZendeskArticle;
      return leadText +
          separator +
          article.category +
          separator +
          article.section +
          separator +
          article.title;
    }
    return catText;
  }
}
