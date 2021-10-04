/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class ApiKnowledgeModelCompanyScore {
  double? sensitivityScore;
  double? breachScore;
  double? securityScore;

  ApiKnowledgeModelCompanyScore(
      {this.sensitivityScore, this.breachScore, this.securityScore});

  ApiKnowledgeModelCompanyScore.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.sensitivityScore = json['sensitivityScore'];
      this.breachScore = json['breachScore'];
      this.securityScore = json['securityScore'];
    }
  }

  Map<String, dynamic> toJson() => {
        'sensitivityScore': sensitivityScore,
        'breachScore': breachScore,
        'securityScore': securityScore
      };
}
