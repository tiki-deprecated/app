/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:provider/provider.dart';

import 'info_carousel_card_service.dart';
import 'ui/info_carousel_card_layout.dart';

class InfoCarouselCardPresenter {
  final InfoCarouselCardService service;

  InfoCarouselCardPresenter(this.service);

  ChangeNotifierProvider<InfoCarouselCardService> render() {
    return ChangeNotifierProvider.value(
        value: service, child: InfoCarouselCardLayout());
  }
}
