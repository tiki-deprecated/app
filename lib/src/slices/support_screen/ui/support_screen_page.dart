import '../../api_zendesk/model/api_zendesk_article.dart';
import '../../api_zendesk/model/api_zendesk_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../support_screen_service.dart';
import 'support_screen_layout.dart';

class SupportScreenPage extends Page {

  final SupportScreenService service;

  final GlobalKey navigatorKey = new GlobalKey();

  SupportScreenPage(this.service)
      : super(key: ValueKey('UserAccountModalPage'));

  @override
  Route createRoute(BuildContext context) => MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => ChangeNotifierProvider.value(
          value: service,
          child: Navigator( key: navigatorKey,
              pages:  getPages()
          )
      )
  );

  List<Page> getPages(){
    return [
      MaterialPage(key: ValueKey(service.data), child: SupportScreenLayout(null)),
      if (service.data is List<ApiZendeskSection>)
        MaterialPage(key: ValueKey(service.data), child: SupportScreenLayout(service.data)),
      if (service.data is List<ApiZendeskArticle>)
        MaterialPage(key: ValueKey(service.data), child: SupportScreenLayout(service.data)),
      if (service.data is ApiZendeskArticle)
        MaterialPage(key: ValueKey(service.data), child: SupportScreenLayout(service.data)),
    ];
  }
}
