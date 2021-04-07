/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_login/helper_login_model_state.dart';

class HelperLoginModel {
  String email;
  String otp;
  String bearer;
  String refresh;
  HelperLoginModelState state = HelperLoginModelState.pending;
  bool semaphore = false;

  HelperLoginModel(
      {this.email,
      this.otp,
      this.bearer,
      this.refresh,
      this.state = HelperLoginModelState.pending,
      this.semaphore = false});
}
