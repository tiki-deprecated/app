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
      this.image = json['image'];
      this.text = json['text'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {'text': text, 'image': image};
}
