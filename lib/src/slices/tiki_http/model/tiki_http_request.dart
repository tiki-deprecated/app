import 'package:http/http.dart';

import 'tiki_request_type.dart';

class TikiHttpRequest {
  final TikiRequestType type;
  final Uri uri;
  Map<String, String>? headers;
  String? body;
  void Function(Response) onSuccess = (resp) => print(resp);
  void Function(Object) onError = (error) => print(error);
  void Function(Response)? onRefresh;
  bool _canceled = false;

  TikiHttpRequest({
    required this.uri,
    required this.type,
    this.headers,
    this.body,
    onSuccess,
    onError,
    this.onRefresh,
  }) {
    if (onSuccess != null) this.onSuccess = onSuccess;
    if (onError != null) this.onSuccess = onError;
  }

  void cancel() => _canceled = true;

  get isCanceled => _canceled;

  @override
  bool operator ==(Object other) => identical(this, other);
}
