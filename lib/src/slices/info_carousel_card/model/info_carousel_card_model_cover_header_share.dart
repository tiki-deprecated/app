/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../utils/json/json_object.dart';

class InfoCarouselCardModelCoverHeaderShare extends JsonObject {
  String? message;
  String? image;

  InfoCarouselCardModelCoverHeaderShare({this.message, this.image});

  InfoCarouselCardModelCoverHeaderShare.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      message = json['message'];
      image = json['image'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {'message': message, 'image': image};

  InfoCarouselCardModelCoverHeaderShare.fromDynamic(dynamic data) {
    message = data.message;
    image = data.image;
  }
}
