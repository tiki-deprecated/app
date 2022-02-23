/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../utils/json/json_object.dart';
import 'info_carousel_card_model_content_body.dart';
import 'info_carousel_card_model_content_cta.dart';

class InfoCarouselCardModelContent extends JsonObject {
  InfoCarouselCardModelContentBody? body;
  InfoCarouselCardModelContentCta? cta;

  InfoCarouselCardModelContent({this.body, this.cta});

  InfoCarouselCardModelContent.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.body = InfoCarouselCardModelContentBody.fromJson(json['body']);
      this.cta = InfoCarouselCardModelContentCta.fromJson(json['cta']);
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'body': body!.toJson(),
        'cta': cta!.toJson(),
      };

  InfoCarouselCardModelContent.fromDynamic(dynamic data){
    body = InfoCarouselCardModelContentBody.fromDynamic(data.body);
    cta = InfoCarouselCardModelContentCta.fromDynamic(cta);
  }
}
