/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../api_knowledge/model/edge/api_knowledge_model_edge.dart';
import '../../api_knowledge/model/edge/api_knowledge_model_edge_vertex.dart';

class DataPushModel {
  int? queueId;
  String? fromType;
  String? fromValue;
  String? toType;
  String? toValue;
  String? fingerprint;
  DateTime? created;

  DataPushModel(
      {this.queueId,
      this.fromType,
      this.fromValue,
      this.toType,
      this.toValue,
      this.fingerprint,
      this.created});

  DataPushModel.fromMap(Map<String, dynamic> map)
      : queueId = map['queue_id'],
        fromType = map['from_type'],
        fromValue = map['from_value'],
        toType = map['to_type'],
        toValue = map['to_value'],
        fingerprint = map['fingerprint'] {
    int? createdEpoch = map['created_epoch'];
    if (createdEpoch != null) {
      created = DateTime.fromMillisecondsSinceEpoch(createdEpoch);
    }
  }

  DataPushModel.fromEdge(ApiKnowledgeModelEdge edge)
      : fromValue = edge.from?.value,
        fromType = edge.from?.type,
        toValue = edge.to?.value,
        toType = edge.to?.type,
        fingerprint = edge.fingerprint;

  Map<String, dynamic> toMap() {
    return {
      'queue_id': queueId,
      'from_type': fromType,
      'from_value': fromValue,
      'to_type': toType,
      'to_value': toValue,
      'fingerprint': fingerprint,
      'created_epoch': created?.millisecondsSinceEpoch,
    };
  }

  ApiKnowledgeModelEdge toEdge() {
    return ApiKnowledgeModelEdge(
        from: ApiKnowledgeModelEdgeVertex(
          type: fromType,
          value: fromValue,
        ),
        to: ApiKnowledgeModelEdgeVertex(
          type: toType,
          value: toValue,
        ),
        fingerprint: fingerprint);
  }
}
