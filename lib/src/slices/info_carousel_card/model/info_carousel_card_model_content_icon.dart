/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class InfoCarouselCardModelContentIcon {
  String? image;
  String? text;

  InfoCarouselCardModelContentIcon({this.image, this.text});

  InfoCarouselCardModelContentIcon.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.image = json['image'];
      this.text = json['text'];
    }
  }

  Map<String, dynamic> toJson() => {'text': text, 'image': image};
}
