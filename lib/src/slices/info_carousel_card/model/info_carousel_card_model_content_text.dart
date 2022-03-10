/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../utils/json/json_object.dart';

class InfoCarouselCardModelContentText extends JsonObject {
  String? text;
  String? url;

  InfoCarouselCardModelContentText({this.text, this.url});

  InfoCarouselCardModelContentText.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      text = json['text'];
      url = json['url'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {'text': text, 'url': url};

  InfoCarouselCardModelContentText.fromDynamic(dynamic data) {
    text = data.text;
    url = data.url;
  }
}
