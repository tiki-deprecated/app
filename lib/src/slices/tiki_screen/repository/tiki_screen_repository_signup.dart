/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:app/src/config/config_domain.dart';
import 'package:app/src/slices/api/helpers/helper_api_rsp.dart';
import 'package:http/http.dart' as http;

import '../../api/helpers/helper_headers.dart';
import '../../login_screen/model/repo_api_website_users_rsp.dart';

class TikiScreenRepositorySignup {
  static const String _path = '/api/0-1-0/user';

  static Future<HelperApiRsp<RepoApiWebsiteUsersRsp>> total({code}) async {
    var query;
    if (code != null) query = {"referrer": code};
    http.Response rsp = await http.get(
        ConfigDomain.asUri(ConfigDomain.website, _path, query),
        headers: HelperHeaders().header);
    Map? rspMap = jsonDecode(rsp.body);
    return HelperApiRsp(
        code: rsp.statusCode,
        data: RepoApiWebsiteUsersRsp.fromJson(rspMap as Map<String, dynamic>?));
  }
}
