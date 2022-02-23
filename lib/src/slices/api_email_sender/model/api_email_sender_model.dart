/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:google_provider/src/model/email/google_provider_model_sender.dart';

import '../../../utils/json/json_object.dart';
import '../../api_company/model/api_company_model.dart';

class ApiEmailSenderModel extends JsonObject {
  int? senderId;
  ApiCompanyModel? company;
  String? name;
  String? email;
  String? category;
  String? unsubscribeMailTo;
  DateTime? emailSince;
  bool? unsubscribed;
  DateTime? ignoreUntil;
  DateTime? created;
  DateTime? modified;

  ApiEmailSenderModel(
      {this.senderId,
      this.company,
      this.name,
      this.email,
      this.category,
      this.unsubscribeMailTo,
      this.emailSince,
      DateTime? ignoreUntil,
      this.unsubscribed = false,
      this.modified,
      this.created})
      : this.ignoreUntil =
            ignoreUntil ?? DateTime.fromMillisecondsSinceEpoch(0);

  ApiEmailSenderModel.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.senderId = json['sender_id'];
      this.company = ApiCompanyModel.fromJson(json['company']);
      this.name = json['name'];
      this.email = json['email'];
      this.category = json['category'];
      this.unsubscribeMailTo = json['unsubscribe_mail_to'];
      this.unsubscribed = json['unsubscribed_bool'] == 1 ? true : false;
      if (json['ignore_until_epoch'] != null)
        this.ignoreUntil =
            DateTime.fromMillisecondsSinceEpoch(json['ignore_until_epoch']);
      if (json['email_since_epoch'] != null)
        this.emailSince =
            DateTime.fromMillisecondsSinceEpoch(json['email_since_epoch']);
      if (json['modified_epoch'] != null)
        this.modified =
            DateTime.fromMillisecondsSinceEpoch(json['modified_epoch']);
      if (json['created_epoch'] != null)
        this.created =
            DateTime.fromMillisecondsSinceEpoch(json['created_epoch']);
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'sender_id': senderId,
        'company_domain': company?.domain,
        'name': name,
        'email': email,
        'category': category,
        'unsubscribe_mail_to': unsubscribeMailTo,
        'email_since_epoch': emailSince?.millisecondsSinceEpoch,
        'ignore_until_epoch': ignoreUntil?.millisecondsSinceEpoch,
        'unsubscribed_bool': unsubscribed == true ? 1 : 0,
        'modified_epoch': modified?.millisecondsSinceEpoch,
        'created_epoch': created?.millisecondsSinceEpoch
      };

  @override
  String toString() {
    return 'ApiEmailSenderModel{senderId: $senderId, company: $company, name: $name, email: $email, category: $category, unsubscribeMailTo: $unsubscribeMailTo, emailSince: $emailSince, unsubscribed: $unsubscribed, ignoreUntil: $ignoreUntil}';
  }

  ApiEmailSenderModel.fromDynamic(dynamic sender) {
    senderId = sender.senderId;
    company = ApiCompanyModel.fromDynamic(sender.company);
    name = sender.name;
    email = sender.email;
    category = sender.category;
    unsubscribeMailTo = sender.unsubscribeMailTo;
    emailSince = sender.emailSince;
    unsubscribed = sender.unsubscribed;
    ignoreUntil = sender.ignoreUntil;
    created = sender.created;
    modified = sender.modified;
  }
}
