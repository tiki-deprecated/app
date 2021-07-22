/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class ApiCompanyIndexModelRspType {
  String? sector;
  String? industry;
  String? subIndustry;
  List<String>? tags;

  ApiCompanyIndexModelRspType(
      {this.sector, this.industry, this.subIndustry, this.tags});

  ApiCompanyIndexModelRspType.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.sector = json['sector'];
      this.industry = json['industry'];
      this.subIndustry = json['subIndustry'];
      this.tags = List.from(json['tags']);
    }
  }

  Map<String, dynamic> toJson() => {
        'sector': sector,
        'industry': industry,
        'subIndustry': subIndustry,
        'tags': tags
      };
}
