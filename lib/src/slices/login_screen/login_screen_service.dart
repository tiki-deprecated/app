import 'package:app/src/slices/api/helper_api_rsp.dart';
import 'package:app/src/slices/app/model/app_model_current.dart';
import 'package:app/src/slices/app/model/app_model_user.dart';
import 'package:app/src/slices/app/repository/secure_storage_repository_current.dart';
import 'package:app/src/slices/app/repository/secure_storage_repository_user.dart';
import 'package:app/src/slices/auth/repository/repo_api_bouncer_jwt.dart';
import 'package:app/src/slices/auth/repository/repo_api_bouncer_jwt_req_otp.dart';
import 'package:app/src/slices/auth/repository/repo_api_bouncer_jwt_rsp.dart';
import 'package:app/src/slices/auth/repository/repo_api_bouncer_otp.dart';
import 'package:app/src/slices/auth/repository/repo_api_bouncer_otp_req.dart';
import 'package:app/src/slices/auth/repository/repo_api_bouncer_otp_rsp.dart';
import 'package:app/src/slices/auth/repository/secure_storage_repository_otp.dart';
import 'package:app/src/slices/auth/repository/secure_storage_repository_token.dart';
import 'package:app/src/slices/login_screen/model/login_screen_model_otp.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';

import 'model/login_screen_model.dart';
import 'model/login_screen_model_token.dart';

class LoginScreenService extends ChangeNotifier{
  static const String _ssKey = 'req';

  LoginScreenModel model = LoginScreenModel();

  bool _isValidEmail(){
    return EmailValidator.validate(this.model.email);
  }

  onEmailChange(String email){
    this.model.email = email;
    this.model.canSubmit = _isValidEmail();
    notifyListeners();
  }


  verifyOtp(String otp) async{
    LoginScreenModelOtp model = await SecureStorageRepositoryOtp().find( SecureStorageRepositoryOtp.reqKey);
    if (model.email != null && model.salt != null) {
      HelperApiRsp<RepoApiBouncerJwtRsp> rsp = await RepoApiBouncerJwt.otp(RepoApiBouncerJwtReqOtp(otp, model.salt));
      if (rsp.code == 200) {
        RepoApiBouncerJwtRsp rspData = rsp.data;
        await SecureStorageRepositoryToken().save(
            model.email!,
            LoginScreenModelToken(
                bearer: rspData.accessToken,
                refresh: rspData.refreshToken,
                expiresIn: rspData.expiresIn));

        AppModelUser user = await SecureStorageRepositoryUser().find(model.email!);
        if (user.address != null) {
          await SecureStorageRepositoryUser().save(
              model.email!,
              AppModelUser(
                  email: model.email, address: user.address, isLoggedIn: true));
          // emit(LoginOtpValidSuccess(true));
        } else {
          await SecureStorageRepositoryUser().save(model.email!,
              AppModelUser(email: model.email, isLoggedIn: false));
          // emit(LoginOtpValidSuccess(false));
        }
      } else {
        SecureStorageRepositoryOtp().delete(_ssKey);
        // emit(LoginOtpValidFailure());
      }
    } else {
      // emit(LoginOtpValidFailure());
    }
  }

  processLogin(String email, String salt) async{
    await SecureStorageRepositoryOtp().save(
        SecureStorageRepositoryOtp.reqKey,
        LoginScreenModelOtp(email: email, salt: salt)
    );
    await SecureStorageRepositoryCurrent().save(
        SecureStorageRepositoryCurrent.key,
        AppModelCurrent(email: email)
    );
  }

  submitLogin() async {
    HelperApiRsp<RepoApiBouncerOtpRsp> rsp =
      await RepoApiBouncerOtp.email(RepoApiBouncerOtpReq(this.model.email));
    if (rsp.code == 200) {
      processLogin(this.model.email, rsp.data.salt);
    } else {
      this.model.isError = true;
    }
  }

  getUI() {}

}
