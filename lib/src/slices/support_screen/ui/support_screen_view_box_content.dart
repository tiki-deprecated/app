import '../../api_zendesk/model/api_zendesk_article.dart';
import '../support_screen_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class SupportScreenViewBoxContent extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    SupportScreenService service = Provider.of<SupportScreenService>(context);
    ApiZendeskArticle data = service.model.data as ApiZendeskArticle;
    String content = data.content;
    return Html(
        data: content
    );
  }
}

