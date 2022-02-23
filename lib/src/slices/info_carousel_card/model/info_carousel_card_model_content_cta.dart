/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../utils/json/json_object.dart';
import '../../../utils/json/json_utils.dart';
import 'info_carousel_card_model_content_text.dart';

class InfoCarouselCardModelContentCta extends JsonObject {
  List<InfoCarouselCardModelContentText>? explain;
  String? buttonText;
  String? buttonUrl;

  InfoCarouselCardModelContentCta(
      {this.explain, this.buttonText, this.buttonUrl});

  InfoCarouselCardModelContentCta.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.buttonText = json['buttonText'];
      this.buttonUrl = json['buttonUrl'];
      this.explain = JsonUtils.listFromJson(
          json['explain'], (s) => InfoCarouselCardModelContentText.fromJson(s));
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'buttonText': buttonText,
        'buttonUrl': buttonUrl,
        'explain': JsonUtils.listToJson(explain)
      };

  InfoCarouselCardModelContentCta.fromDynamic(dynamic data){
    explain = data.explain.map((explainData) =>  InfoCarouselCardModelContentText.fromDynamic(explainData)).toList();
    buttonText = data.buttonText;
    buttonUrl = data.buttonUrl;
  }
}
