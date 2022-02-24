/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../utils/json/json_object.dart';
import '../../../utils/json/json_utils.dart';
import 'info_carousel_card_model_content_icon.dart';
import 'info_carousel_card_model_content_text.dart';

class InfoCarouselCardModelContentBody extends JsonObject {
  List<InfoCarouselCardModelContentText>? explain;
  List<InfoCarouselCardModelContentIcon>? theySay;
  List<InfoCarouselCardModelContentIcon>? shouldKnow;

  InfoCarouselCardModelContentBody(
      {this.explain, this.theySay, this.shouldKnow});

  InfoCarouselCardModelContentBody.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.theySay = JsonUtils.listFromJson(
          json['theySay'], (s) => InfoCarouselCardModelContentIcon.fromJson(s));
      this.shouldKnow = JsonUtils.listFromJson(json['shouldKnow'],
          (s) => InfoCarouselCardModelContentIcon.fromJson(s));
      this.explain = JsonUtils.listFromJson(
          json['explain'], (s) => InfoCarouselCardModelContentText.fromJson(s));
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'theySay': JsonUtils.listToJson(theySay),
        'shouldKnow': JsonUtils.listToJson(shouldKnow),
        'explain': JsonUtils.listToJson(explain)
      };

  InfoCarouselCardModelContentBody.fromDynamic(dynamic data) {
    explain = data.explain
        .map((explainData) =>
            InfoCarouselCardModelContentText.fromDynamic(explainData))
        .toList();
    theySay = data.theySay
        .map((theySayData) =>
            InfoCarouselCardModelContentIcon.fromDynamic(theySayData))
        .toList();
    ;
    shouldKnow = data.shouldKnow
        .map((shouldKnowData) =>
            InfoCarouselCardModelContentIcon.fromDynamic(shouldKnowData))
        .toList();
    ;
  }
}
