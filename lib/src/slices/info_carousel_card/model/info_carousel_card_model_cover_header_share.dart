/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class InfoCarouselCardModelCoverHeaderShare {
  String? message;
  String? image;

  InfoCarouselCardModelCoverHeaderShare({this.message, this.image});

  InfoCarouselCardModelCoverHeaderShare.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.message = json['message'];
      this.image = json['image'];
    }
  }

  Map<String, dynamic> toJson() => {'message': message, 'image': image};
}
