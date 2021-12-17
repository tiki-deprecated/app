import '../../../config/config_color.dart';
import '../../api_zendesk/model/api_zendesk_article.dart';
import '../../api_zendesk/model/api_zendesk_category.dart';
import '../model/support_screen_type.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../support_screen_service.dart';

class SupportScreenViewBoxSubtitle extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    SupportScreenService service = Provider.of<SupportScreenService>(context);
    TextSpan text = getSubtitle(service);
    return RichText(
        text:text
    );
  }

  TextSpan getSubtitle(SupportScreenService service) {
    Color color = getColor(service);
    switch(service.model.type){
      case SupportScreenType.category:
        ApiZendeskCategory category = service.model.data as ApiZendeskCategory;
        num count = service.getArticlesCount(category);
        return TextSpan(text: count.toString() + " articles", style: TextStyle(color: color));
      case SupportScreenType.section:
        return TextSpan(
            text: "published in ", style: TextStyle(color: color),
            children: [
              TextSpan(
                text: service.model.parentName,
                style: TextStyle(fontWeight: FontWeight.bold)
              )
            ],
        );
     case SupportScreenType.article:
       DateTime date = (service.model.data as ApiZendeskArticle).updatedAt;
       String publishedDate = DateFormat("dd MMMM YYYY").format(date);
       return TextSpan(
         text: "published on $publishedDate", style: TextStyle(color: color),
       );
    }
  }

  Color getColor(SupportScreenService service) {
    switch(service.model.type){
      case SupportScreenType.category:
        return ConfigColor.blue;
      case SupportScreenType.section:
      case SupportScreenType.article:
        return ConfigColor.greyFive;
    }
  }
}