/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class InfoCarouselCardModelContentText {
  String? text;
  String? url;

  InfoCarouselCardModelContentText({this.text, this.url});

  InfoCarouselCardModelContentText.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.text = json['text'];
      this.url = json['url'];
    }
  }

  Map<String, dynamic> toJson() => {'text': text, 'url': url};
}
