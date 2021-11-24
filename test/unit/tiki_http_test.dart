
import 'package:app/src/slices/tiki_http/model/tiki_http_request.dart';
import 'package:app/src/slices/tiki_http/model/tiki_request_type.dart';
import 'package:app/src/slices/tiki_http/tiki_http_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

void main() {
  test('simple http request', () async {
   final TikiHttpClient tikiHttpClient = TikiHttpClient();
   TikiHttpRequest request = TikiHttpRequest(
     uri: Uri.parse("https://google.com"),
     type: TikiRequestType.GET,
   );
   request.onSuccess = (response){
     expect(response is Response, true);
     expect(response.statusCode, 200);
   };
   await tikiHttpClient.request(request);
  });
}