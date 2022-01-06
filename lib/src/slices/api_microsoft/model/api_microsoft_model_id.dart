/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../utils/json/json_object.dart';

class ApiMicrosoftModelId extends JsonObject {
  String? etag;
  String? id;

  ApiMicrosoftModelId({this.etag, this.id});

  ApiMicrosoftModelId.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      etag = json['@odata.etag'];
      id = json['id'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {'@odata.etag': etag, 'id': id};
}
