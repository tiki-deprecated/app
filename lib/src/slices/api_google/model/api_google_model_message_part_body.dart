/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../utils/json/json_object.dart';

class ApiGoogleModelMessagePartBody extends JsonObject {
  String? attachmentId;
  int? size;
  String? data;

  ApiGoogleModelMessagePartBody({this.attachmentId, this.size, this.data});

  ApiGoogleModelMessagePartBody.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      attachmentId = json['attachmentId'];
      size = json['size'];
      data = json['data'];
    }
  }

  @override
  Map<String, dynamic> toJson() =>
      {'attachmentId': attachmentId, 'size': size, 'data': data};
}
