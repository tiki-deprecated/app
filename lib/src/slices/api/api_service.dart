import 'dart:convert';

import 'package:app/src/config/config_domain.dart';
import 'package:app/src/slices/api/helpers/helper_api_auth.dart';
import 'package:app/src/slices/app/repository/secure_storage_repository_current.dart';
import 'package:app/src/slices/auth/repository/secure_storage_repository_token.dart';
import 'package:app/src/slices/blockchain/model/blockchain_model_address_rsp_code.dart';
import 'package:app/src/slices/blockchain/repository/blockchain_repository_address.dart';
import 'package:app/src/slices/login_screen/model/repo_api_website_users_rsp.dart';
import 'package:app/src/slices/tiki_screen/repository/tiki_screen_repository_signup.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'helpers/helper_api_rsp.dart';
import 'helpers/helper_headers.dart';

class ApiService {
  final secureStorageRepositoryCurrent;
  final repoLocalSsToken;
  late HelperApiAuth helperApiAuth;

  ApiService()
      : secureStorageRepositoryCurrent = SecureStorageRepositoryCurrent(
            secureStorage: FlutterSecureStorage()),
        repoLocalSsToken = SecureStorageRepositoryToken(
            secureStorage: FlutterSecureStorage()) {
    helperApiAuth =
        HelperApiAuth(secureStorageRepositoryCurrent, repoLocalSsToken);
  }

  Future<String?> getReferralCode(String address) async {
    BlockchainRepositoryAddress blockchainRepositoryAddress =
        BlockchainRepositoryAddress.provide();
    HelperApiRsp<BlockchainModelAddressRspCode> rsp =
        await blockchainRepositoryAddress.referCode(address);
    if (rsp.code == 200 && rsp.data != null)
      return rsp.data.code;
    else
      throw Exception("Failed to get refer code");
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

  Future<int?> getReferCount(String code) async {
    HelperApiRsp<RepoApiWebsiteUsersRsp> apiRsp =
        await TikiScreenRepositorySignup.total(code: code);
    if (apiRsp.code == 200) {
      return apiRsp.data.total;
    }
  }
}
