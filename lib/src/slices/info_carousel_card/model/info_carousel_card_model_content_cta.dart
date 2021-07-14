/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/utils/helper_json.dart';

import 'info_carousel_card_model_content_text.dart';

class InfoCarouselCardModelContentCta {
  List<InfoCarouselCardModelContentText>? explain;
  String? buttonText;
  String? buttonUrl;

  InfoCarouselCardModelContentCta(
      {this.explain, this.buttonText, this.buttonUrl});

  InfoCarouselCardModelContentCta.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.buttonText = json['buttonText'];
      this.buttonUrl = json['buttonUrl'];
      this.explain = HelperJson.listFromJson(
          json['explain'], (s) => InfoCarouselCardModelContentText.fromJson(s));
    }
  }

  Map<String, dynamic> toJson() => {
        'buttonText': buttonText,
        'buttonUrl': buttonUrl,
        'explain': HelperJson.listToJson(explain)
      };
}
