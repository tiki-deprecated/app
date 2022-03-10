/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';

import '../api_email_msg/model/api_email_msg_model.dart';
import '../api_oauth/model/api_oauth_model_account.dart';
import 'model/api_microsoft_model_id.dart';
import 'model/api_microsoft_model_rsp.dart';
import 'repository/api_microsoft_repository_email.dart';

class ApiMicrosoftServiceEmailPaginator {
  final _log = Logger('ApiMicrosoftServiceEmailPaginator');

  static const int MAX_RESULTS = 1000;
  static const int NUM_REQUESTS = 10;

  final ApiMicrosoftRepositoryEmail repositoryEmail;
  final void Function(List<ApiEmailMsgModel> messages)? onSuccess;
  final void Function(Object error)? onError;
  final void Function(HttppResponse response)? onResult;
  final ApiOAuthModelAccount? account;
  final DateTime? since;
  int _page = 0;
  late final HttppClient httppClient;

  ApiMicrosoftServiceEmailPaginator(
      {required this.httppClient,
      required this.repositoryEmail,
      void Function()? onFinish,
      this.onSuccess,
      this.onResult,
      this.onError,
      this.since,
      this.account});

  Future<void> fetchInbox() async {
    List<Future> futures = [];
    for (int i = 0; i < NUM_REQUESTS; i++) {
      futures.add(_fetch());
    }
    await Future.wait(futures);
  }

  Future<void> _fetch() {
    Future<void> future = repositoryEmail.messageId(
        client: httppClient,
        accessToken: account?.accessToken,
        filter:
            _buildFilter(page: _page, maxResults: MAX_RESULTS, after: since),
        onSuccess: _onSuccess,
        onResult: _onResult,
        onError: _onError);
    _page++;
    return future;
  }

  Future<void> _onSuccess(HttppResponse response) async {
    ApiMicrosoftModelRsp model = ApiMicrosoftModelRsp.fromJson(
        response.body?.jsonBody, (json) => ApiMicrosoftModelId.fromJson(json));

    if (model.nextLink != null) await _fetch();

    if (onSuccess != null) {
      List<ApiMicrosoftModelId> messages = List.castFrom(model.value);
      onSuccess!(
          (messages).map((m) => ApiEmailMsgModel(extMessageId: m.id)).toList());
    }
  }

  void _onResult(HttppResponse response) {
    _log.warning(
        'Fetch inbox ${account?.username} failed with statusCode ${response.statusCode}');
    if (onResult != null) onResult!(response);
  }

  void _onError(Object error) {
    _log.warning('Fetch inbox ${account?.username} failed with error $error');
    if (onError != null) onError!(error);
  }

  //we dont use from anymore
  String _buildFilter({DateTime? after, int page = 0, int maxResults = 10}) {
    StringBuffer queryBuffer = StringBuffer();
    if (after != null) {
      _appendQuery(queryBuffer,
          'receivedDateTime ge ${after.toUtc().toIso8601String()}');
    }
    int skip = page * maxResults;
    queryBuffer.write('&\$skip=$skip&\$top=$maxResults');
    return queryBuffer.toString();
  }

  StringBuffer _appendQuery(StringBuffer queryBuffer, String append) {
    if (queryBuffer.isNotEmpty) {
      queryBuffer.write(' and ');
    }
    queryBuffer.write(append);
    return queryBuffer;
  }
}
