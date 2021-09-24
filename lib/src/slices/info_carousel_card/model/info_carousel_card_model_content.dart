/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'info_carousel_card_model_content_body.dart';
import 'info_carousel_card_model_content_cta.dart';

class InfoCarouselCardModelContent {
  InfoCarouselCardModelContentBody? body;
  InfoCarouselCardModelContentCta? cta;

  InfoCarouselCardModelContent({this.body, this.cta});

  InfoCarouselCardModelContent.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.body = InfoCarouselCardModelContentBody.fromJson(json['body']);
      this.cta = InfoCarouselCardModelContentCta.fromJson(json['cta']);
    }
  }

  Map<String, dynamic> toJson() => {
        'body': body!.toJson(),
        'cta': cta!.toJson(),
      };
}
