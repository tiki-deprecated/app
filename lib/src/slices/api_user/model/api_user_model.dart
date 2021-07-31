/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api_user/model/api_user_model_current.dart';
import 'package:app/src/slices/api_user/model/api_user_model_keys.dart';
import 'package:app/src/slices/api_user/model/api_user_model_otp.dart';
import 'package:app/src/slices/api_user/model/api_user_model_token.dart';
import 'package:app/src/slices/api_user/model/api_user_model_user.dart';

class ApiUserModel {
  ApiUserModelCurrent? current;
  ApiUserModelUser? user;
  ApiUserModelToken? token;
  ApiUserModelOtp? otp;
  ApiUserModelKeys? keys;
  bool isGmailLinked = false;
  bool isTestCardDone = false;
}
