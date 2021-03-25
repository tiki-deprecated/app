/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_login_router/helper_login_router_model_state.dart';

class HelperLoginRouterModel {
  String email;
  String otp;
  String bearer;
  String refresh;
  HelperLoginRouterModelState state = HelperLoginRouterModelState.pending;

  HelperLoginRouterModel(
      {this.email,
      this.otp,
      this.bearer,
      this.refresh,
      this.state = HelperLoginRouterModelState.pending});
}
