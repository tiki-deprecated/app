/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';

import '../../utils/api/tiki_api_model_rsp.dart';
import 'api_short_code_model_claim.dart';
import 'api_short_code_model_rsp.dart';

class ApiShortCodeRepository {
  final Logger _log = Logger('ApiShortCodeRepository');
  static const String _authority = 'bouncer.mytiki.com';
  static const String _path = '/api/latest/short-code';

  Future<void> post(
      {required HttppClient client,
      String? accessToken,
      ApiShortCodeModelClaim? body,
      void Function(TikiApiModelRsp<ApiShortCodeModelRsp>)? onSuccess,
      void Function(Object)? onError}) async {
    HttppRequest request = HttppRequest(
        uri: Uri.https(_authority, _path),
        verb: HttppVerb.POST,
        body: HttppBody.fromJson(body?.toJson()),
        headers: HttppHeaders.typical(bearerToken: accessToken),
        timeout: const Duration(seconds: 30),
        onSuccess: (rsp) {
          if (onSuccess != null) {
            onSuccess(TikiApiModelRsp.fromJson(rsp.body?.jsonBody,
                (json) => ApiShortCodeModelRsp.fromJson(json)));
          }
        },
        onResult: (rsp) {
          if (onError != null) {
            onError(TikiApiModelRsp.fromJson(rsp.body?.jsonBody, (json) {}));
          }
        },
        onError: onError);
    _log.finest('${request.verb.value} — ${request.uri}');
    return client.request(request);
  }

  Future<void> get(
      {required HttppClient client,
      String? accessToken,
      required String address,
      void Function(TikiApiModelRsp<ApiShortCodeModelRsp>)? onSuccess,
      void Function(Object)? onError}) async {
    HttppRequest request = HttppRequest(
        uri: Uri.https(_authority, _path, {'address': address}),
        verb: HttppVerb.GET,
        headers: HttppHeaders.typical(bearerToken: accessToken),
        timeout: const Duration(seconds: 30),
        onSuccess: (rsp) {
          if (onSuccess != null) {
            onSuccess(TikiApiModelRsp.fromJson(rsp.body?.jsonBody,
                (json) => ApiShortCodeModelRsp.fromJson(json)));
          }
        },
        onResult: (rsp) {
          if (onError != null) {
            onError(TikiApiModelRsp.fromJson(rsp.body?.jsonBody, (json) {}));
          }
        },
        onError: onError);
    _log.finest('${request.verb.value} — ${request.uri}');
    return client.request(request);
  }
}
