/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:async';

import 'package:app/src/slices/api/helper_api_rsp.dart';
import 'package:app/src/slices/api/repo_api_bouncer_jwt/repo_api_bouncer_jwt.dart';
import 'package:app/src/slices/api/repo_api_bouncer_jwt/repo_api_bouncer_jwt_req_otp.dart';
import 'package:app/src/slices/api/repo_api_bouncer_jwt/repo_api_bouncer_jwt_rsp.dart';
import 'package:app/src/slices/app/model/app_model_user.dart';
import 'package:app/src/slices/app/repository/secure_storage_repository_user.dart';
import 'package:app/src/slices/keys_screen/secure_storage_repository_otp.dart';
import 'package:app/src/slices/login_screen/model/login_screen_model_otp.dart';
import 'package:app/src/slices/login_screen/model/login_screen_model_token.dart';
import 'package:app/src/slices/login_screen/secure_storage_repository_token.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_otp_valid_event.dart';
part 'login_otp_valid_state.dart';

class LoginOtpValidBloc extends Bloc<LoginOtpValidEvent, LoginOtpValidState> {
  static const String _ssKey = 'req';
  final RepoApiBouncerJwt _repoApiBouncerJwt;
  final SecureStorageRepositoryOtp _repoLocalSsOtp;
  final SecureStorageRepositoryToken _repoLocalSsToken;
  final SecureStorageRepositoryUser _repoLocalSsUser;

  LoginOtpValidBloc(this._repoApiBouncerJwt, this._repoLocalSsOtp,
      this._repoLocalSsToken, this._repoLocalSsUser)
      : super(LoginOtpValidInitial());

  LoginOtpValidBloc.provide(BuildContext context)
      : _repoApiBouncerJwt = RepositoryProvider.of<RepoApiBouncerJwt>(context),
        _repoLocalSsOtp =
            RepositoryProvider.of<SecureStorageRepositoryOtp>(context),
        _repoLocalSsToken =
            RepositoryProvider.of<SecureStorageRepositoryToken>(context),
        _repoLocalSsUser =
            RepositoryProvider.of<SecureStorageRepositoryUser>(context),
        super(LoginOtpValidInitial());

  @override
  Stream<LoginOtpValidState> mapEventToState(
    LoginOtpValidEvent event,
  ) async* {
    if (event is LoginOtpValidChanged)
      yield* _mapChangedToState(event);
    else if (event is LoginOtpValidLoaded) yield* _mapLoadedToState(event);
  }

  Future<void> update(String otp) async {
    emit(LoginOtpValidInProgress(otp));
  }

  Stream<LoginOtpValidState> _mapChangedToState(
      LoginOtpValidChanged changed) async* {
    yield LoginOtpValidInProgress(changed.otp);
  }

  Stream<LoginOtpValidState> _mapLoadedToState(
      LoginOtpValidLoaded loaded) async* {
    LoginScreenModelOtp model = await _repoLocalSsOtp.find(_ssKey);
    if (model.email != null && model.salt != null) {
      HelperApiRsp<RepoApiBouncerJwtRsp> rsp = await _repoApiBouncerJwt
          .otp(RepoApiBouncerJwtReqOtp(loaded.otp, model.salt));
      if (rsp.code == 200) {
        RepoApiBouncerJwtRsp rspData = rsp.data;
        await _repoLocalSsToken.save(
            model.email!,
            LoginScreenModelToken(
                bearer: rspData.accessToken,
                refresh: rspData.refreshToken,
                expiresIn: rspData.expiresIn));

        AppModelUser user = await _repoLocalSsUser.find(model.email!);
        if (user.address != null) {
          await _repoLocalSsUser.save(
              model.email!,
              AppModelUser(
                  email: model.email, address: user.address, isLoggedIn: true));
          emit(LoginOtpValidSuccess(true));
        } else {
          await _repoLocalSsUser.save(model.email!,
              AppModelUser(email: model.email, isLoggedIn: false));
          emit(LoginOtpValidSuccess(false));
        }
      } else {
        _repoLocalSsOtp.delete(_ssKey);
        emit(LoginOtpValidFailure());
      }
    } else
      emit(LoginOtpValidFailure());
  }
}
