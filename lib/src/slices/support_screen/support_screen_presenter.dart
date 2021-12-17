/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api_zendesk/model/api_zendesk_article.dart';

import '../api_zendesk/model/api_zendesk_category.dart';
import '../api_zendesk/model/api_zendesk_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../config/config_color.dart';
import 'support_screen_service.dart';
import 'ui/support_screen_layout.dart';

class SupportScreenPresenter {
  final SupportScreenService service;

  SupportScreenPresenter(this.service);

  Navigator render() {
    final  GlobalKey<NavigatorState> navigatorKey =  GlobalKey<NavigatorState>();
    return Navigator(
      key: navigatorKey,
      pages:  <Page<void>>[
        MaterialPage(key: ValueKey(service.data), child: SupportScreenLayout(null)),
        if (service.data is List<ApiZendeskCategory>)
          MaterialPage(key: ValueKey(service.data), child: SupportScreenLayout(service.data)),
        if (service.data is List<ApiZendeskSection>)
          MaterialPage(key: ValueKey(service.data), child: SupportScreenLayout(service.data)),
        if (service.data is List<ApiZendeskArticle>)
          MaterialPage(key: ValueKey(service.data), child: SupportScreenLayout(service.data)),
      ],
      onPopPage: _handlePopPage,
    );
  }

  Future<void> showModal(BuildContext context) {
    return showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        backgroundColor: ConfigColor.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(4.5.h))),
        builder: (BuildContext context) => render());
  }

  bool _handlePopPage(Route route, result) {
    final bool success = route.didPop(result);
    if (success) {
      service.data =  null;
      service.update();
    }
    return success;
  }
}
