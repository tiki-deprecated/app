/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/info_carousel_card/model/info_carousel_card_model_content_text.dart';
import 'package:app/src/utils/helper_json.dart';

import 'info_carousel_card_model_content_icon.dart';

class InfoCarouselCardModelContentBody {
  List<InfoCarouselCardModelContentText>? explain;
  List<InfoCarouselCardModelContentIcon>? theySay;
  List<InfoCarouselCardModelContentIcon>? shouldKnow;

  InfoCarouselCardModelContentBody(
      {this.explain, this.theySay, this.shouldKnow});

  InfoCarouselCardModelContentBody.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.theySay = HelperJson.listFromJson(
          json['theySay'], (s) => InfoCarouselCardModelContentIcon.fromJson(s));
      this.shouldKnow = HelperJson.listFromJson(json['shouldKnow'],
          (s) => InfoCarouselCardModelContentIcon.fromJson(s));
      this.explain = HelperJson.listFromJson(
          json['explain'], (s) => InfoCarouselCardModelContentText.fromJson(s));
    }
  }

  Map<String, dynamic> toJson() => {
        'theySay': HelperJson.listToJson(theySay),
        'shouldKnow': HelperJson.listToJson(shouldKnow),
        'explain': HelperJson.listToJson(explain)
      };
}
