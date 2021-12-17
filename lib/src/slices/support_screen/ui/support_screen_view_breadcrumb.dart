import '../../../config/config_color.dart';
import '../../api_zendesk/model/api_zendesk_article.dart';
import '../../api_zendesk/model/api_zendesk_category.dart';
import '../../api_zendesk/model/api_zendesk_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../support_screen_service.dart';

class SupportScreenViewBreadcrumb extends StatelessWidget {
  final String catText =
      "Welcome to our Help Center. Search for an\nanswer or check out our articles below.";
  final String separator = " > ";
  final Color catColor = ConfigColor.tikiBlue;
  final Color defaultColor = ConfigColor.greyFive;

  @override
  Widget build(BuildContext context) {
    SupportScreenService service = Provider.of<SupportScreenService>(context);
    String text = getBreadcrumbText(service);
    return Text(text,
        style: TextStyle(
            color: service.data == null ? this.catColor : this.defaultColor));
  }

  String getBreadcrumbText(SupportScreenService service) {
    String leadText = "All categories";
    if(service.data is List<ApiZendeskCategory>) {
      ApiZendeskCategory category = service.data as ApiZendeskCategory;
      return leadText + separator + category.title;
    }
    if(service.data is List<ApiZendeskSection>) {
      ApiZendeskSection section = service.data as ApiZendeskSection;
      return leadText +
          separator +
          section.category +
          separator +
          section.title;
    }
    if(service.data is ApiZendeskArticle || service.data is List<ApiZendeskArticle>) {
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
