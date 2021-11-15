/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:logging/logging.dart';
import 'package:sqflite_sqlcipher/sqlite_api.dart';

import '../../utils/api/helper_api_rsp.dart';
import '../../utils/api/helper_api_utils.dart';
import '../api_knowledge/api_knowledge_service.dart';
import 'model/data_push_model.dart';
import 'repository/data_push_repository.dart';

class DataPushService {
  final _log = Logger('DataPushService');
  static final int _pushOn = 250;
  final DataPushRepository _repository;
  final ApiKnowledgeService _apiKnowledgeService;

  DataPushService(
      {required ApiKnowledgeService apiKnowledgeService,
      required Database database})
      : this._apiKnowledgeService = apiKnowledgeService,
        this._repository = DataPushRepository(database);

  Future<void> write(List<DataPushModel> edges, {bool force = false}) async {
    await _repository.insert(edges);
    int size = await _repository.getSize();
    if (size >= _pushOn) {
      List<DataPushModel> edgesToPush =
          await _repository.getAll(limit: _pushOn);
      HelperApiRsp rsp = await _apiKnowledgeService
          .addEdges(edgesToPush.map((e) => e.toEdge()).toList());
      if (HelperApiUtils.is2xx(rsp.code)) {
        List<int> ids = edgesToPush
            .where((e) => e.queueId != null)
            .map((e) => e.queueId!)
            .toList();
        await _repository.deleteByIds(ids);
      }
    }
  }
}
