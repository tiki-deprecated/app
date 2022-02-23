/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../utils/json/json_object.dart';
import 'info_carousel_card_model_cover_header_share.dart';

class InfoCarouselCardModelCoverHeader extends JsonObject {
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

  @override
  Map<String, dynamic> toJson() =>
      {'title': title, 'image': image, 'share': share?.toJson()};

  InfoCarouselCardModelCoverHeader.fromDynamic(dynamic data) {
    image = data.image;
    title = data.title;
    share = InfoCarouselCardModelCoverHeaderShare.fromDynamic(data.share);
  }
}
