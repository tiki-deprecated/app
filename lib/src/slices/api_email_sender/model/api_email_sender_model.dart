/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../api_company/model/api_company_model_local.dart';

class ApiEmailSenderModel {
  int? senderId;
  int? accountId;
  ApiCompanyModelLocal? company;
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
      this.accountId,
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

  ApiEmailSenderModel.fromMap(map) {
    this.senderId = map['sender_id'];
    this.accountId = map['account_id'];
    this.company = ApiCompanyModelLocal.fromMap(map['company']);
    this.name = map['name'];
    this.email = map['email'];
    this.category = map['category'];
    this.unsubscribeMailTo = map['unsubscribe_mail_to'];
    this.unsubscribed = map['unsubscribed_bool'] == 1 ? true : false;
    if (map['ignore_until_epoch'] != null)
      this.ignoreUntil =
          DateTime.fromMillisecondsSinceEpoch(map['ignore_until_epoch']);
    if (map['email_since_epoch'] != null)
      this.emailSince =
          DateTime.fromMillisecondsSinceEpoch(map['email_since_epoch']);
    if (map['modified_epoch'] != null)
      this.modified =
          DateTime.fromMillisecondsSinceEpoch(map['modified_epoch']);
    if (map['created_epoch'] != null)
      this.created = DateTime.fromMillisecondsSinceEpoch(map['created_epoch']);
  }

  Map<String, dynamic> toMap() => {
        'sender_id': senderId,
        'account_id': accountId,
        'company_id': company?.companyId,
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
    return 'ApiEmailSenderModel{senderId: $senderId, accountId: $accountId, company: $company, name: $name, email: $email, category: $category, unsubscribeMailTo: $unsubscribeMailTo, emailSince: $emailSince, unsubscribed: $unsubscribed, ignoreUntil: $ignoreUntil}';
  }
}
