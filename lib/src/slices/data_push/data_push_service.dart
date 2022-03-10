/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:logging/logging.dart';
import 'package:login/login.dart';
import 'package:sqflite_sqlcipher/sqlite_api.dart';

import '../api_knowledge/api_knowledge_service.dart';
import 'model/data_push_model.dart';
import 'repository/data_push_repository.dart';

class DataPushService {
  final _log = Logger('DataPushService');
  static const int _pushOn = 250;
  final DataPushRepository _repository;
  final ApiKnowledgeService _apiKnowledgeService;
  final Login _login;

  DataPushService(
      {required ApiKnowledgeService apiKnowledgeService,
      required Database database,
      required Login login})
      : _apiKnowledgeService = apiKnowledgeService,
        _repository = DataPushRepository(database),
        _login = login;

  Future<void> write(List<DataPushModel> edges, {bool force = false}) async {
    await _repository.insert(edges);
    int size = await _repository.getSize();
    if (size >= _pushOn) {
      List<DataPushModel> edgesToPush =
          await _repository.getAll(limit: _pushOn);
      await _apiKnowledgeService.addEdges(
          edges: edgesToPush.map((e) => e.toEdge()).toList(),
          accessToken: _login.token!.bearer!,
          onSuccess: (rsp) async {
            List<int> ids = edgesToPush
                .where((e) => e.queueId != null)
                .map((e) => e.queueId!)
                .toList();
            await _repository.deleteByIds(ids);
          },
          onError: (error) => _log.warning(error));
    }
  }
}
