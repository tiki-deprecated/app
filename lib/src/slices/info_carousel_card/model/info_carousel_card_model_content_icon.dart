/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../utils/json/json_object.dart';

class InfoCarouselCardModelContentIcon extends JsonObject {
  String? image;
  String? text;

  InfoCarouselCardModelContentIcon({this.image, this.text});

  InfoCarouselCardModelContentIcon.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      image = json['image'];
      text = json['text'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {'text': text, 'image': image};

  InfoCarouselCardModelContentIcon.fromDynamic(dynamic data) {
    image = data.image;
    text = data.text;
  }
}
