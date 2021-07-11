/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/login_flow/model/login_flow_model_path.dart';
import 'package:flutter/widgets.dart';

class LoginFlowInformationParser
    extends RouteInformationParser<LoginFlowModelPath> {
  @override
  Future<LoginFlowModelPath> parseRouteInformation(
      RouteInformation routeInformation) {
    return Future.value(LoginFlowModelPath());
  }
}
