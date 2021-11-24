import 'model/tiki_request_type.dart';
import 'package:logging/logging.dart';

import 'package:http/http.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'dart:collection';

import 'model/tiki_http_request.dart';

/// A http client with a queue to handle simultaneous requests.
class TikiHttpClient{
  Logger _log = Logger("tikiHttpClient");
  int _queueLimit = 100;
  int _activeRequests = 0;
  ListQueue<TikiHttpRequest> _queue = ListQueue<TikiHttpRequest>();

  /// Add a [TikiHttpRequest] to the queue
  Future<void> request(TikiHttpRequest request) async {
    if (_activeRequests < _queueLimit) {
      _dispatchRequest(request);
    }else{
      _queue.add(request);
    }
  }

  /// Run the request, handle callbacks and errors.
  Future<void> _dispatchRequest(TikiHttpRequest tikiRequest) async {
    final client = SentryHttpClient();
    try {
      _activeRequests++;
      Response response = await _sendRequest(tikiRequest, client);
      if(isNot2xx(response.statusCode)){
        String code = response.statusCode.toString();
        String uriStr = tikiRequest.uri.toString();
        String type = tikiRequest.type.toString();
        throw "$uriStr $type request failed with error code $code";
      }
      if(tikiRequest.onSuccess != null) tikiRequest.onSuccess!(response);
    } catch (error) {
      _log.warning(error);
      if(tikiRequest.onError != null) tikiRequest.onError!(error);
    }finally{
      client.close();
      _activeRequests--;
      _next();
    }
  }

  /// Remove next [TikiHttpRequest] from the queue and run.
  _next() {
    if (_activeRequests < _queueLimit && _queue.isNotEmpty){
      TikiHttpRequest request = _queue.removeFirst();
      _dispatchRequest(request);
    }
  }

  Future<Response>_sendRequest(TikiHttpRequest tikiRequest, SentryHttpClient client) async {
    Uri uri = tikiRequest.uri;
    Response response;
    switch(tikiRequest.type){
      case TikiRequestType.GET :
        response = await client.get(uri, headers: tikiRequest.headers);
        break;
      case TikiRequestType.POST :
        response = await client.post(uri, headers: tikiRequest.headers, body: tikiRequest.body);
        break;
      case TikiRequestType.PUT :
        response = await client.put(uri, headers: tikiRequest.headers, body: tikiRequest.body);
        break;
      case TikiRequestType.DELETE :
        response = await client.delete(uri, headers: tikiRequest.headers);
        break;
      case TikiRequestType.HEAD :
        response = await client.head(uri, headers: tikiRequest.headers);
        break;
      default :
        throw Exception("HTTP request type not allowed");
    }
    return response;
  }

  static bool is2xx(int? code) => (code != null && code >= 200 && code < 300);

  static bool isNot2xx(int? code) =>
      (code == null || code < 200 || code <= 300);

  static bool is3xx(int? code) => (code != null && code >= 300 && code < 400);

  static bool is4xx(int? code) => (code != null && code >= 400 && code < 500);

  static bool is5xx(int? code) => (code != null && code >= 500);

  static bool isOk(int? code) => (code != null && code == 200);

  static bool isNotOk(int? code) => (code == null || code != 200);

  static bool isBadRequest(int? code) => (code != null && code == 400);

  static bool isUnauthorized(int? code) => (code != null && code == 401);

  static bool isForbidden(int? code) => (code != null && code == 403);

  static bool isNotFound(int? code) => (code != null && code == 404);

  static bool isUnprocessable(int? code) => (code != null && code == 422);


}