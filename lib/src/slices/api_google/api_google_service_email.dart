/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:collection/src/iterable_extensions.dart';
import 'package:google_provider/google_provider.dart';
import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';

import '../api_company/api_company_service.dart';
import '../api_company/model/api_company_model.dart';
import '../api_email_msg/model/api_email_msg_model.dart';
import '../api_email_sender/model/api_email_sender_model.dart';
import '../api_oauth/api_oauth_service.dart';
import '../api_oauth/model/api_oauth_model_account.dart';
import '../data_fetch/data_fetch_interface_email.dart';
import 'model/api_google_model_error.dart';
import 'model/api_google_model_header.dart';
import 'model/api_google_model_message.dart';
import 'model/api_google_model_messages.dart';
import 'repository/api_google_repository_email.dart';

class ApiGoogleServiceEmail extends DataFetchInterfaceEmail {
  final _log = Logger('ApiGoogleServiceEmail');

  final Httpp _httpp;
  final ApiOAuthService apiOAuthService;
  final ApiGoogleRepositoryEmail _repositoryEmail;

  ApiGoogleServiceEmail(this.apiOAuthService, this._httpp)
      : _repositoryEmail = ApiGoogleRepositoryEmail();

  @override
  Future<void> fetchInbox(
      {required ApiOAuthModelAccount account,
      DateTime? since,
      required Function(List<ApiEmailMsgModel> messages) onResult,
      required Function() onFinish}) {
    return GoogleProvider.loggedIn(
        email: account.email,
        token: account.accessToken,
        refreshToken: account.refreshToken,
        displayName: account.displayName,
        httpp: _httpp
    ).fetchInbox(
        onResult: (msgIdList) => onResult(
            msgIdList.map((msgId) => ApiEmailMsgModel(extMessageId: msgId)).toList()
        ),
        onFinish: onFinish
    );
  }

  @override
  Future<void> send(
      {required ApiOAuthModelAccount account,
      String? body,
      required String to,
      String? subject,
      Function(bool success)? onResult}) async {
    String message = '''
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit
to: $to
from: me
subject: $subject
    
$body
''';
    String base64Email = base64UrlEncode(utf8.encode(message));
    HttppClient client = _httpp.client();
    return _repositoryEmail.send(
        client: client,
        accessToken: account.accessToken,
        message: HttppBody.fromJson(
            ApiGoogleModelMessage(raw: base64Email).toJson()),
        onSuccess: (response) {
          _log.finest('unsubscribe mail sent to ' + to);
          if (onResult != null) onResult(true);
        },
        onResult: (response) async {
          _log.warning('unsubscribe for ${to} failed.');
          _handleUnauthorized(client, response, account);
          _handleTooManyRequests(client, response);
          if (onResult != null) onResult(false);
        },
        onError: (error) {
          _log.warning('unsubscribe for ${to} failed.');
          if (onResult != null) onResult(false);
        });
  }

  @override
  Future<void> fetchMessages(
      {required ApiOAuthModelAccount account,
      required List<String> messageIds,
      required Function(ApiEmailMsgModel message) onResult,
      required Function() onFinish}) async {
        return GoogleProvider.loggedIn(
            email: account.email,
            token: account.accessToken,
            refreshToken: account.refreshToken,
            displayName: account.displayName,
            httpp: _httpp
        ).fetchMessages(
            messageIds: messageIds,
            onResult: (msg) =>
                onResult(
                    ApiEmailMsgModel.fromDynamic(msg)
                ),
            onFinish: onFinish
        );
  }

  void _handleUnauthorized(HttppClient client, HttppResponse response,
      ApiOAuthModelAccount account) {
    if (HttppUtils.isUnauthorized(response.statusCode)) {
      _log.warning('Unauthorized. Trying refresh');
      client.denyUntil(response.request!, () async {
        ApiOAuthModelAccount? refreshed =
            await apiOAuthService.refreshToken(account);
        response.request?.headers?.auth(refreshed?.accessToken);
      });
    }
  }

  void _handleTooManyRequests(HttppClient client, HttppResponse response) {
    if (HttppUtils.isForbidden(response.statusCode)) {
      ApiGoogleModelError error =
          ApiGoogleModelError.fromJson(response.body?.jsonBody['error']);
      error.errors?.forEach((error) {
        if (error.reason == 'rateLimitExceeded') {
          _log.warning('Too many requests. Retry after');
          client.denyFor(response.request!, Duration(seconds: 1));
          return;
        }
      });
    }
  }
}
