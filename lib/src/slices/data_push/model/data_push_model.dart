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
      : this.queueId = map['queue_id'],
        this.fromType = map['from_type'],
        this.fromValue = map['from_value'],
        this.toType = map['to_type'],
        this.toValue = map['to_value'],
        this.fingerprint = map['fingerprint'] {
    int? createdEpoch = map['created_epoch'];
    if (createdEpoch != null)
      this.created = DateTime.fromMillisecondsSinceEpoch(createdEpoch);
  }

  DataPushModel.fromEdge(ApiKnowledgeModelEdge edge)
      : this.fromValue = edge.from?.value,
        this.fromType = edge.from?.type,
        this.toValue = edge.to?.value,
        this.toType = edge.to?.type,
        this.fingerprint = edge.fingerprint;

  Map<String, dynamic> toMap() {
    return {
      'queue_id': this.queueId,
      'from_type': this.fromType,
      'from_value': this.fromValue,
      'to_type': this.toType,
      'to_value': this.toValue,
      'fingerprint': this.fingerprint,
      'created_epoch': created?.millisecondsSinceEpoch,
    };
  }

  ApiKnowledgeModelEdge toEdge() {
    return ApiKnowledgeModelEdge(
        from: ApiKnowledgeModelEdgeVertex(
          type: this.fromType,
          value: this.fromValue,
        ),
        to: ApiKnowledgeModelEdgeVertex(
          type: this.toType,
          value: this.toValue,
        ),
        fingerprint: this.fingerprint);
  }
}
