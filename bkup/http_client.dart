import 'dart:collection';

import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'http_request.dart';
import 'http_response.dart';
import 'http_utils.dart';
import 'http_verb.dart';

/// A http client with a queue to handle simultaneous requests.
class HttpClient {
  Logger _log = Logger("HttpClient");
  int _queueLimit = 100;
  int _activeRequests = 0;
  ListQueue<HttpRequest> _queue = ListQueue<HttpRequest>();
  Set<String> _denyList = Set();

  get activeRequests => _activeRequests;

  get queuedRequests => _queue.length;

  /// Add a [HttpRequest] to the queue
  Future<void> request(HttpRequest request) async {
    if (_activeRequests < _queueLimit) {
      await _dispatchRequest(request);
    } else {
      _queue.add(request);
    }
  }

  Future<void> deny(String host, {int? milliseconds}) async {
    if (!_denyList.contains(host)) {
      _log.fine("Adding $host to denylist");
      _denyList.add(host);
      if (milliseconds != null) {
        await Future.delayed(
            Duration(milliseconds: (milliseconds * 1.5).toInt()),
            () => allow(host));
      }
    }
  }

  void allow(String host) {
    if (_denyList.contains(host)) {
      _log.fine("Removing $host from denylist");
      _denyList.remove(host);
    }
  }

  /// Run the request, handle callbacks and errors.
  Future<void> _dispatchRequest(HttpRequest request) async {
    final client = SentryHttpClient();
    try {
      if (request.isCanceled) {
        _log.info('ignoring canceled request');
      } else if (_denyList.contains(request.uri.host)) {
        _log.info('denylist stopped request');
        await Future.delayed(
            Duration(milliseconds: 100), () => this.request(request));
      } else {
        _activeRequests++;
        _log.finest('${request.type.value} ${request.uri.toString()}');

        StreamedResponse streamedResponse =
            await client.send(request.toRequest()).onError((error, stackTrace) {
          String uriStr = request.uri.toString();
          String type = request.type.value!;
          throw error ?? "$uriStr $type request - client send error";
        });
        HttpResponse response = HttpResponse.fromResponse(
            request, await Response.fromStream(streamedResponse));

        if (request.tooManyReqDelay != null &&
            HttpUtils.isTooManyRequests(response.statusCode)) {
          deny(request.uri.host,
              milliseconds: request.tooManyReqDelay!(response));
          this.request(request);
        } else if (request.refreshAuth != null &&
            HttpUtils.isUnauthorized(response.statusCode)) {
          deny(request.uri.host);
          String token = await request.refreshAuth!(response);
          request.headers!.auth(token);
          this.request(request);
        } else if (request.on2xx != null &&
            HttpUtils.is2xx(response.statusCode)) {
          request.on2xx!(response);
        } else if (request.onResult != null) {
          request.onResult!(response);
        }
      }
    } catch (error) {
      _log.warning(error);
      if (request.onError != null) request.onError!(error);
    } finally {
      client.close();
      _activeRequests > 0 ? _activeRequests - 1 : 0;
      _next();
    }
  }

  /// Remove next [HttpRequest] from the queue and run.
  _next() {
    if (_activeRequests < _queueLimit && _queue.isNotEmpty) {
      HttpRequest request = _queue.removeFirst();
      _dispatchRequest(request);
    }
  }
}
