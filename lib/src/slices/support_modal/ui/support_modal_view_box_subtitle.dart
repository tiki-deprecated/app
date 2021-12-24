import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../../../config/config_font.dart';
import '../../api_zendesk/model/api_zendesk_article.dart';
import '../../api_zendesk/model/api_zendesk_category.dart';
import '../../api_zendesk/model/api_zendesk_section.dart';

class SupportModalViewBoxSubtitle extends StatelessWidget {
  final dynamic data;

  SupportModalViewBoxSubtitle(this.data);

  @override
  Widget build(BuildContext context) {
    TextSpan text = getSubtitle();
    return Container(
        alignment: Alignment.centerLeft, child: RichText(text: text));
  }

  TextSpan getSubtitle() {
    Color color = getColor(data);
    if (data is ApiZendeskCategory) {
      num count = data.sections.length;
      String text = count.toString() + " sections";
      return TextSpan(
        text: text,
        style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: color,
            fontFamily: ConfigFont.familyNunitoSans),
      );
    }
    if (data is ApiZendeskSection) {
      num count = data.articles.length;
      String text = count.toString() + " articles";
      return TextSpan(
          text: text,
          style:
              TextStyle(color: color, fontFamily: ConfigFont.familyNunitoSans));
    }
    if (data is ApiZendeskArticle) {
      DateTime date = data.updatedAt;
      String publishedDate = DateFormat("dd MMMM YYYY").format(date);
      return TextSpan(
        text: "published on $publishedDate",
        style: TextStyle(color: color, fontFamily: ConfigFont.familyNunitoSans),
      );
    }
    return TextSpan(text: '');
  }

  Color getColor(data) {
    if (data is ApiZendeskCategory || data is ApiZendeskSection)
      return ConfigColor.blue;
    return ConfigColor.greyFive;
  }
}
