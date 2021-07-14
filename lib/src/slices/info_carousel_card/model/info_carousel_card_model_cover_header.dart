/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'info_carousel_card_model_cover_header_share.dart';

class InfoCarouselCardModelCoverHeader {
  String? image;
  String? title;
  InfoCarouselCardModelCoverHeaderShare? share;

  InfoCarouselCardModelCoverHeader({this.image, this.title, this.share});

  InfoCarouselCardModelCoverHeader.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.title = json['title'];
      this.image = json['image'];
      this.share =
          InfoCarouselCardModelCoverHeaderShare.fromJson(json['share']);
    }
  }

  Map<String, dynamic> toJson() =>
      {'title': title, 'image': image, 'share': share?.toJson()};
}
