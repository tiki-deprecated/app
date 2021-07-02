/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'info_carousel_card_model_content.dart';
import 'info_carousel_card_model_cover.dart';

class InfoCarouselCardModel {
  InfoCarouselCardModelCover? cover;
  InfoCarouselCardModelContent? content;

  InfoCarouselCardModel({this.cover, this.content});

  InfoCarouselCardModel.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.cover = InfoCarouselCardModelCover.fromJson(json['cover']);
      this.content = InfoCarouselCardModelContent.fromJson(json['content']);
    }
  }

  Map<String, dynamic> toJson() => {
        'cover': cover!.toJson(),
        'content': content!.toJson(),
      };
}
