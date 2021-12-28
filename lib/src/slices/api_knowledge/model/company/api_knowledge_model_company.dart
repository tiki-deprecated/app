/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../../utils/json/json_object.dart';
import 'api_knowledge_model_company_about.dart';
import 'api_knowledge_model_company_score.dart';
import 'api_knowledge_model_company_social.dart';
import 'api_knowledge_model_company_type.dart';

class ApiKnowledgeModelCompany extends JsonObject {
  ApiKnowledgeModelCompanyAbout? about;
  ApiKnowledgeModelCompanyScore? score;
  ApiKnowledgeModelCompanySocial? social;
  ApiKnowledgeModelCompanyType? type;

  ApiKnowledgeModelCompany({this.about, this.score, this.social, this.type});

  ApiKnowledgeModelCompany.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.about = ApiKnowledgeModelCompanyAbout.fromJson(json['about']);
      this.score = ApiKnowledgeModelCompanyScore.fromJson(json['score']);
      this.social = ApiKnowledgeModelCompanySocial.fromJson(json['social']);
      this.type = ApiKnowledgeModelCompanyType.fromJson(json['type']);
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'about': about?.toJson(),
        'score': score?.toJson(),
        'social': social?.toJson(),
        'type': type?.toJson()
      };
}
