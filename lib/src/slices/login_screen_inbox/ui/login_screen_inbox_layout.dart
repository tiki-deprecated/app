/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../keys_modal/keys_modal_service.dart';
import '../../login_flow/model/login_flow_model_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login_screen_inbox_service.dart';
import 'login_screen_inbox_layout_background.dart';
import 'login_screen_inbox_layout_foreground.dart';

class LoginScreenInboxLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginScreenInboxService service = Provider.of<LoginScreenInboxService>(context);
    if(service.loginFlowService.model.state == LoginFlowModelState.creatingKeys)
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) =>
          KeysModalService(service.loginFlowService).presenter.showModal(context)
      );
    return Scaffold(
        body: Center(
            child: Stack(children: [
      LoginScreenInboxLayoutBackground(),
      LoginScreenInboxLayoutForeground(),
    ])));
  }
}
