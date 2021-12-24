import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../../../config/config_font.dart';
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
        padding: EdgeInsets.only(top: 3.h),
        alignment: Alignment.centerLeft,
        child: Text(text,
            style: TextStyle(
                color: service.model.data == null ||
                        service.model.data is List<ApiZendeskCategory>
                    ? this.catColor
                    : this.defaultColor,
                fontFamily: ConfigFont.familyNunitoSans,
                fontWeight: FontWeight.w600,
                fontSize: 11.sp),
            textAlign: TextAlign.start));
  }

  String _getBreadcrumbText(SupportModalService service) {
    String leadText = "All categories";
    if (service.model.data == null) return '';
    if (service.model.data is List<ApiZendeskSection> && service.model.data.length > 0) {
      String cat = service.model.category?.title ?? '';
      return leadText + separator + cat;
    }
    if (service.model.data is List<ApiZendeskArticle>) {
      String cat = service.model.category?.title ?? '';
      String section = service.model.section?.title ?? '';
      return leadText + separator + cat + separator + section;
    } else if (service.model.data is ApiZendeskArticle) {
      String cat = service.model.category?.title ?? '';
      String section = service.model.section?.title ?? '';
      return leadText +
          separator +
          cat +
          separator +
          section +
          separator +
          service.model.data.title;
    }
    return catText;
  }
}
