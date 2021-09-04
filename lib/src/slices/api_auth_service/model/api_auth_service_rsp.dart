import 'dart:convert';

class ApiAuthServiceRsp {
  String? status;
  int? code;
  Map<String, dynamic>? data;

  ApiAuthServiceRsp({this.status, this.code, this.data});

  ApiAuthServiceRsp.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.status = json['status'];
      this.code = json['code'];
      this.data = jsonDecode(json['data']);
    }
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'code': code,
        'data': data,
      };
}
