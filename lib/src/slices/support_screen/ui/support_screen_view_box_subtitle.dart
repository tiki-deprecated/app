import '../../api_zendesk/model/api_zendesk_section.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../config/config_color.dart';
import '../../api_zendesk/model/api_zendesk_article.dart';
import '../../api_zendesk/model/api_zendesk_category.dart';
import '../support_screen_service.dart';

class SupportScreenViewBoxSubtitle extends StatelessWidget {
  final dynamic data;

  SupportScreenViewBoxSubtitle(this.data);

  @override
  Widget build(BuildContext context) {
    SupportScreenService service = Provider.of<SupportScreenService>(context);
    TextSpan text = getSubtitle(service);
    return RichText(text: text);
  }

  TextSpan getSubtitle(dynamic data) {
    Color color = getColor(data);
    if (data is ApiZendeskCategory) {
      num count = data.sections.length;
      String text = count.toString() + " sections";
      return TextSpan(text: text, style: TextStyle(color: color));
    }
    if (data is ApiZendeskSection) {
      num count = data.articles.length;
      String text = count.toString() + " articles";
      return TextSpan(text: text, style: TextStyle(color: color));
    }
    if (data is ApiZendeskArticle) {
      DateTime date = data.updatedAt;
      String publishedDate = DateFormat("dd MMMM YYYY").format(date);
      return TextSpan(
        text: "published on $publishedDate",
        style: TextStyle(color: color),
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
