/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/security_score_modal/ui/security_score_modal_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'security_score_modal_service.dart';

class SecurityScoreModalPresenter {
  final SecurityScoreModalService service;

  SecurityScoreModalPresenter(this.service);

  ChangeNotifierProvider<SecurityScoreModalService> render() {
    return ChangeNotifierProvider.value(
        value: service, child: SecurityScoreModalLayout());
  }

  Future<void> showModal(BuildContext context) {
    return showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        backgroundColor: ConfigColor.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(4.5.h))),
        builder: (BuildContext context) => render());
  }
}
