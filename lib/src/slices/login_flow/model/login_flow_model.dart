/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api_user/model/api_user_model.dart';
import 'package:app/src/slices/login_flow/model/login_flow_model_state.dart';

class LoginFlowModel {
  LoginFlowModelState? state;
  ApiUserModel? user;
}
