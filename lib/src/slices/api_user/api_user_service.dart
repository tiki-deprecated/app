/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../config/config_sentry.dart';
import 'model/api_user_model.dart';
import 'model/api_user_model_current.dart';
import 'model/api_user_model_otp.dart';
import 'model/api_user_model_token.dart';
import 'model/api_user_model_user.dart';
import 'repository/api_user_repository_current.dart';
import 'repository/api_user_repository_otp.dart';
import 'repository/api_user_repository_token.dart';
import 'repository/api_user_repository_user.dart';

class ApiUserService {
  final ApiUserRepositoryCurrent _repositoryCurrent;
  final ApiUserRepositoryUser _repositoryUser;
  final ApiUserRepositoryToken _repositoryToken;
  final ApiUserRepositoryOtp _repositoryOtp;

  ApiUserService(FlutterSecureStorage secureStorage)
      : _repositoryCurrent = ApiUserRepositoryCurrent(secureStorage),
        _repositoryUser = ApiUserRepositoryUser(secureStorage),
        _repositoryToken = ApiUserRepositoryToken(secureStorage),
        _repositoryOtp = ApiUserRepositoryOtp(secureStorage);

  Future<ApiUserModel> get() async {
    ApiUserModel model = ApiUserModel();
    model.current = await _repositoryCurrent.find(ApiUserRepositoryCurrent.key);
    if (model.current?.email != null) {
      model.user = await _repositoryUser.find(model.current!.email!);
      model.token = await _repositoryToken.find(model.current!.email!);
      model.otp = await _repositoryOtp.find(model.current!.email!);
    }
    return model;
  }

  Future<void> setCurrent(String email) async {
    await _repositoryCurrent.save(
        ApiUserRepositoryCurrent.key, ApiUserModelCurrent(email: email));
  }

  Future<void> setUser(ApiUserModelUser user) async {
    if (user.email == null)
      ConfigSentry.message(
          "Attempting to write to user without an email. Skipping",
          level: ConfigSentry.levelWarn);
    else
      await _repositoryUser.save(user.email!, user);
  }

  Future<void> setToken(String email, ApiUserModelToken token) async {
    await _repositoryToken.save(email, token);
  }

  Future<void> setOtp(ApiUserModelOtp otp) async {
    if (otp.email == null)
      ConfigSentry.message(
          "Attempting to write to otp without an email. Skipping",
          level: ConfigSentry.levelWarn);
    else
      await _repositoryOtp.save(otp.email!, otp);
  }
}
