/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api_company_index/model/api_company_index_model_rsp_about.dart';
import 'package:app/src/slices/api_company_index/model/api_company_index_model_rsp_score.dart';
import 'package:app/src/slices/api_company_index/model/api_company_index_model_rsp_social.dart';
import 'package:app/src/slices/api_company_index/model/api_company_index_model_rsp_type.dart';

class ApiCompanyIndexModelRsp {
  ApiCompanyIndexModelRspAbout? about;
  ApiCompanyIndexModelRspScore? score;
  ApiCompanyIndexModelRspSocial? social;
  ApiCompanyIndexModelRspType? type;

  ApiCompanyIndexModelRsp({this.about, this.score, this.social, this.type});

  ApiCompanyIndexModelRsp.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.about = ApiCompanyIndexModelRspAbout.fromJson(json['about']);
      this.score = ApiCompanyIndexModelRspScore.fromJson(json['score']);
      this.social = ApiCompanyIndexModelRspSocial.fromJson(json['social']);
      this.type = ApiCompanyIndexModelRspType.fromJson(json['type']);
    }
  }

  Map<String, dynamic> toJson() => {
        'about': about?.toJson(),
        'score': score?.toJson(),
        'social': social?.toJson(),
        'type': type?.toJson()
      };
}
