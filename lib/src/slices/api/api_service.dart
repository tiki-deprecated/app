import 'dart:convert';

import 'package:app/src/config/config_domain.dart';
import 'package:app/src/slices/api/helpers/helper_api_auth.dart';
import 'package:app/src/slices/app/repository/secure_storage_repository_current.dart';
import 'package:app/src/slices/auth/repository/secure_storage_repository_token.dart';
import 'package:app/src/slices/login_screen/model/repo_api_website_users_rsp.dart';
import 'package:app/src/slices/tiki_screen/repository/repo_api_website_users.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'helpers/helper_api_rsp.dart';
import 'helpers/helper_headers.dart';

class ApiService {
  final secureStorageRepositoryCurrent;
  final repoLocalSsToken;
  late HelperApiAuth helperApiAuth;

  String _referralPath = '/api/latest/address/%%address%%/code';

  ApiService()
      : secureStorageRepositoryCurrent = SecureStorageRepositoryCurrent(
            secureStorage: FlutterSecureStorage()),
        repoLocalSsToken = SecureStorageRepositoryToken(
            secureStorage: FlutterSecureStorage()) {
    helperApiAuth =
        HelperApiAuth(secureStorageRepositoryCurrent, repoLocalSsToken);
  }

  Future<String> getReferalCode(String address) async {
    String? bearer = await helperApiAuth.bearer();
    http.Response rsp = await http.get(
        ConfigDomain.asUri(ConfigDomain.blockchain,
            _referralPath.replaceFirst("%%address%%", address)),
        headers: HelperHeaders(auth: bearer).header);
    if (rsp.statusCode == 200) {
      Map data = jsonDecode(rsp.body);
      var code = data['data']['code'];
      return code;
    } else {
      throw Exception(
          "Referal code error " + rsp.statusCode.toString() + " " + rsp.body);
    }
  }

  getTotal() async {
    var path = '/api/0-1-0/user';
    var headers = HelperHeaders().header;
    http.Response rsp = await http
        .get(ConfigDomain.asUri(ConfigDomain.website, path), headers: headers);
    Map? rspMap = jsonDecode(rsp.body);
    if (rsp.statusCode == 200) {
      return rspMap!["total"];
    }
  }

  void getReferCount(String code) async {
    HelperApiRsp<RepoApiWebsiteUsersRsp> apiRsp =
        await RepoApiWebsiteUsers.total(code: code);
    if (apiRsp.code == 200) {
      return apiRsp.data.total;
    }
  }
}
