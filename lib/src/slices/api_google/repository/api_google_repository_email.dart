/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';

class ApiGoogleRepositoryEmail {
  final Logger _log = Logger('ApiGoogleRepositoryEmail');

  static const String _pathMessages =
      "https://gmail.googleapis.com/gmail/v1/users/me/messages/";
  static const String _pathSend =
      "https://gmail.googleapis.com/gmail/v1/users/me/messages/send";

  ApiGoogleRepositoryEmail();

  Future<void> messageId(
      {required HttppClient client,
      String? accessToken,
      String? filter,
      void Function(HttppResponse)? onSuccess,
      required void Function(HttppResponse) onResult,
      void Function(Object)? onError}) {
    String queryParams = '';
    if (filter != null) queryParams += "?$filter";
    HttppRequest request = HttppRequest(
        uri: Uri.parse(_pathMessages + queryParams),
        verb: HttppVerb.GET,
        headers: HttppHeaders.typical(bearerToken: accessToken),
        timeout: Duration(seconds: 30),
        onSuccess: onSuccess,
        onResult: onResult,
        onError: onError);
    _log.finest('${request.verb.value} — ${request.uri}');
    return client.request(request);
  }

  Future<void> send(
      {required HttppClient client,
      String? accessToken,
      required HttppBody message,
      void Function(HttppResponse)? onSuccess,
      required void Function(HttppResponse) onResult,
      void Function(Object)? onError}) async {
    HttppRequest request = HttppRequest(
        uri: Uri.parse(_pathSend),
        verb: HttppVerb.POST,
        headers: HttppHeaders.typical(bearerToken: accessToken),
        timeout: Duration(seconds: 30),
        body: message,
        onSuccess: onSuccess,
        onResult: onResult,
        onError: onError);
    _log.finest('${request.verb.value} — ${request.uri}');
    return client.request(request);
  }

  Future<void> message(
      {required HttppClient client,
      String? accessToken,
      required String messageId,
      void Function(HttppResponse)? onSuccess,
      required void Function(HttppResponse) onResult,
      void Function(Object)? onError}) async {
    HttppRequest request = HttppRequest(
        uri: Uri.parse(_pathMessages + '$messageId'),
        verb: HttppVerb.GET,
        headers: HttppHeaders.typical(bearerToken: accessToken),
        timeout: Duration(seconds: 30),
        onSuccess: onSuccess,
        onResult: onResult,
        onError: onError);
    _log.finest('${request.verb.value} — ${request.uri}');
    return client.request(request);
  }
}
