/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../utils/json/json_object.dart';
import '../../../utils/json/json_utils.dart';
import 'api_google_model_error_detail.dart';
import 'api_google_model_error_error.dart';

class ApiGoogleModelError extends JsonObject {
  int? code;
  String? message;
  String? status;
  List<ApiGoogleModelErrorError>? errors;
  List<ApiGoogleModelErrorDetail>? details;

  ApiGoogleModelError(
      {this.code, this.message, this.status, this.errors, this.details});

  ApiGoogleModelError.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      code = json['code'];
      message = json['message'];
      status = json['status'];
      errors = JsonUtils.listFromJson(
          json['errors'], (json) => ApiGoogleModelErrorError.fromJson(json));
      details = JsonUtils.listFromJson(
          json['details'], (json) => ApiGoogleModelErrorDetail.fromJson(json));
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        'status': status,
        'errors': JsonUtils.listToJson(errors),
        'details': JsonUtils.listToJson(details)
      };
}
