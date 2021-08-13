/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'api_company_model_index_about.dart';
import 'api_company_model_index_score.dart';
import 'api_company_model_index_social.dart';
import 'api_company_model_index_type.dart';

class ApiCompanyModelIndex {
  ApiCompanyModelIndexAbout? about;
  ApiCompanyModelIndexScore? score;
  ApiCompanyModelIndexSocial? social;
  ApiCompanyModelIndexType? type;

  ApiCompanyModelIndex({this.about, this.score, this.social, this.type});

  ApiCompanyModelIndex.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.about = ApiCompanyModelIndexAbout.fromJson(json['about']);
      this.score = ApiCompanyModelIndexScore.fromJson(json['score']);
      this.social = ApiCompanyModelIndexSocial.fromJson(json['social']);
      this.type = ApiCompanyModelIndexType.fromJson(json['type']);
    }
  }

  Map<String, dynamic> toJson() => {
        'about': about?.toJson(),
        'score': score?.toJson(),
        'social': social?.toJson(),
        'type': type?.toJson()
      };
}
