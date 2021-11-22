import 'tiki_request_type.dart';

class TikiHttpRequest{
  TikiRequestType? type;
  Uri? uri;
  Map<String,String>? headers;
  String? body;
  Function? onSuccess;
  Function? onError;

  @override
  bool operator ==(Object other) => identical(this, other);

}