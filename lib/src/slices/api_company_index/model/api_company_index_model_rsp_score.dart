/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class ApiCompanyIndexModelRspScore {
  double? sensitivityScore;
  double? breachScore;
  double? securityScore;

  ApiCompanyIndexModelRspScore(
      {this.sensitivityScore, this.breachScore, this.securityScore});

  ApiCompanyIndexModelRspScore.fromJson(Map<String, dynamic>? json) {
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
