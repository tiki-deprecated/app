/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/repo/repo_api_bouncer_jwt/repo_api_bouncer_jwt.dart';
import 'package:app/src/features/repo/repo_api_bouncer_jwt/repo_api_bouncer_jwt_req_otp.dart';
import 'package:app/src/features/repo/repo_api_bouncer_jwt/repo_api_bouncer_jwt_rsp.dart';
import 'package:app/src/features/repo/repo_local_ss_otp/repo_local_ss_otp.dart';
import 'package:app/src/features/repo/repo_local_ss_otp/repo_local_ss_otp_model.dart';
import 'package:app/src/features/repo/repo_local_ss_token/repo_local_ss_token.dart';
import 'package:app/src/features/repo/repo_local_ss_token/repo_local_ss_token_model.dart';
import 'package:app/src/utils/helper/helper_api_rsp.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_otp_valid_state.dart';

class LoginOtpValidCubit extends Cubit<LoginOtpValidState> {
  static const String _ssKey = 'req';
  final RepoApiBouncerJwt _repoApiBouncerJwt;
  final RepoLocalSsOtp _repoLocalSsOtp;
  final RepoLocalSsToken _repoLocalSsToken;

  LoginOtpValidCubit(
      this._repoApiBouncerJwt, this._repoLocalSsOtp, this._repoLocalSsToken)
      : super(LoginOtpValidInitial());

  LoginOtpValidCubit.provide(BuildContext context)
      : _repoApiBouncerJwt = RepositoryProvider.of<RepoApiBouncerJwt>(context),
        _repoLocalSsOtp = RepositoryProvider.of<RepoLocalSsOtp>(context),
        _repoLocalSsToken = RepositoryProvider.of<RepoLocalSsToken>(context),
        super(LoginOtpValidInitial());

  Future<void> execute(String otp) async {
    emit(LoginOtpValidInProgress());
    RepoLocalSsOtpModel model = await _repoLocalSsOtp.find(_ssKey);
    HelperApiRsp<RepoApiBouncerJwtRsp> rsp =
        await _repoApiBouncerJwt.otp(RepoApiBouncerJwtReqOtp(otp, model.salt));
    if (rsp.code == 200) {
      RepoApiBouncerJwtRsp rspData = rsp.data;
      await _repoLocalSsToken.save(
          model.email,
          RepoLocalSsTokenModel(
              bearer: rspData.accessToken,
              refresh: rspData.refreshToken,
              expiresIn: rspData.expiresIn));
      emit(LoginOtpValidSuccess());
    } else {
      _repoLocalSsOtp.delete(_ssKey);
      emit(LoginOtpValidFailure());
    }
  }
}
