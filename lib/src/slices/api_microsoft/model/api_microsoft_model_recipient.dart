/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../utils/json/json_object.dart';
import 'api_microsoft_model_email_address.dart';

class ApiMicrosoftModelRecipient extends JsonObject {
  ApiMicrosoftModelEmailAddress? emailAddress;

  ApiMicrosoftModelRecipient({this.emailAddress});

  ApiMicrosoftModelRecipient.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      emailAddress =
          ApiMicrosoftModelEmailAddress.fromJson(json['emailAddress']);
    }
  }

  @override
  Map<String, dynamic> toJson() => {'emailAddress': emailAddress?.toJson()};
}
