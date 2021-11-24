import 'package:http/http.dart';

import 'tiki_request_type.dart';

class TikiHttpRequest{
  final TikiRequestType type;
  final Uri uri;
  Map<String,String>? headers;
  String? body;
  void Function(Response)? onSuccess;
  void Function(Object)? onError;
  void Function(Response)? onRefresh;

  TikiHttpRequest({
    required this.uri,
    required this.type,
    Map<String,String>? headers,
    String? body,
    void Function(Response)? onSuccess,
    void Function(Object)? onError,
    void Function(Response)? onRefresh,
  });

  @override
  bool operator ==(Object other) => identical(this, other);

}