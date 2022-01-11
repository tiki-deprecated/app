/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../keys_modal_service.dart';
import '../model/keys_modal_steps.dart';
import 'keys_modal_view_header.dart';

class KeysModalLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
            height: 85.h,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              KeysModalViewHeader(),
              Expanded(
                  child: SingleChildScrollView(
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 6.w, right: 6.w, bottom: 5.h),
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            Container(child: _getContent(context)),
                          ]))))
            ])));
  }

  Widget _getContent(BuildContext context) {
    KeysModalService service = Provider.of<KeysModalService>(context);
    switch (service.model.step) {
      case KeysModalSteps.newAccountQuestion:
        return KeysModalViewNewAccount();
      case KeysModalSteps.qrCodeQuestion:
        return KeysModalViewQrCodeQuestion();
      case KeysModalSteps.qrCodeScanner:
        return KeysModalViewQrCodeScanner();
      case KeysModalSteps.enterPinCode:
        return KeysModalViewPinCode();
      case KeysModalSteps.enterPassPhrase:
        return KeysModalViewPassPhrase();
      default:
        return KeysModalViewNewAccount();
    }
  }
}

class KeysModalViewPassPhrase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class KeysModalViewPinCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class KeysModalViewQrCodeScanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class KeysModalViewQrCodeQuestion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class KeysModalViewNewAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
