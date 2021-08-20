/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'api_user_model_current.dart';
import 'api_user_model_keys.dart';
import 'api_user_model_otp.dart';
import 'api_user_model_token.dart';
import 'api_user_model_user.dart';

class ApiUserModel {
  ApiUserModelCurrent? current;
  ApiUserModelUser? user;
  ApiUserModelToken? token;
  ApiUserModelOtp? otp;
  ApiUserModelKeys? keys;
}
