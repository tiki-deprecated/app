/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:httpp/httpp.dart';

import '../../utils/api/tiki_api_model_rsp.dart';
import 'api_short_code_model_claim.dart';
import 'api_short_code_model_rsp.dart';
import 'api_short_code_repository.dart';

class ApiShortCodeService {
  final HttppClient _client;
  final Future<void> Function(void Function(String?)? onSuccess)? refresh;
  final ApiShortCodeRepository _repository;

  ApiShortCodeService({Httpp? httpp, this.refresh})
      : _client = httpp?.client() ?? Httpp().client(),
        _repository = ApiShortCodeRepository();

  Future<void> get(
          {required String accessToken,
          required String address,
          Function(Object)? onError,
          Function(ApiShortCodeModelRsp)? onSuccess}) async =>
      _auth(
          accessToken,
          onError,
          (token, onError) => _repository.get(
              client: _client,
              accessToken: token,
              address: address,
              onSuccess: (rsp) {
                if (onSuccess != null)
                  onSuccess(rsp.data as ApiShortCodeModelRsp);
              },
              onError: onError));

  Future<void> claim(
          {required String accessToken,
          required ApiShortCodeModelClaim claim,
          Function(Object)? onError,
          Function(ApiShortCodeModelRsp)? onSuccess}) async =>
      _auth(
          accessToken,
          onError,
          (token, onError) => _repository.post(
              client: _client,
              accessToken: token,
              body: claim,
              onSuccess: (rsp) {
                if (onSuccess != null)
                  onSuccess(rsp.data as ApiShortCodeModelRsp);
              },
              onError: onError));

  Future<T> _auth<T>(String accessToken, Function(Object)? onError,
      Future<T> Function(String, Future<void> Function(Object)) request) async {
    return request(accessToken, (error) async {
      if (error is TikiApiModelRsp && error.code == 401 && refresh != null) {
        await refresh!((token) async {
          if (token != null)
            await request(
                token,
                (error) async =>
                    onError != null ? onError(error) : throw error);
        });
      } else
        onError != null ? onError(error) : throw error;
    });
  }
}
