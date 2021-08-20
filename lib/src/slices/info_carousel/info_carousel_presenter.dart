/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:provider/provider.dart';

import 'info_carousel_service.dart';
import 'ui/info_carousel_screen.dart';

class InfoCarouselPresenter {
  final InfoCarouselService service;

  InfoCarouselPresenter(this.service);

  ChangeNotifierProvider<InfoCarouselService> render() {
    return ChangeNotifierProvider.value(
        value: service, child: InfoCarouselScreen());
  }
}
