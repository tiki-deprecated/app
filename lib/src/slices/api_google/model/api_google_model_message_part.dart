/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../utils/json/json_object.dart';
import '../../../utils/json/json_utils.dart';
import 'api_google_model_header.dart';
import 'api_google_model_message_part_body.dart';

class ApiGoogleModelMessagePart extends JsonObject {
  String? partId;
  String? mimeType;
  String? filename;
  List<ApiGoogleModelHeader>? headers;
  ApiGoogleModelMessagePartBody? body;
  List<ApiGoogleModelMessagePart>? parts;

  ApiGoogleModelMessagePart(
      {this.partId,
      this.mimeType,
      this.filename,
      this.headers,
      this.body,
      this.parts});

  ApiGoogleModelMessagePart.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      partId = json['partId'];
      mimeType = json['mimeType'];
      filename = json['filename'];
      headers = JsonUtils.listFromJson(
          json['headers'], (json) => ApiGoogleModelHeader.fromJson(json));
      body = ApiGoogleModelMessagePartBody.fromJson(json['body']);
      parts = JsonUtils.listFromJson(
          json['parts'], (json) => ApiGoogleModelMessagePart.fromJson(json));
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'partId': partId,
        'mimeType': mimeType,
        'filename': filename,
        'headers': JsonUtils.listToJson(headers),
        'body': body?.toJson(),
        'parts': JsonUtils.listToJson(parts)
      };
}
