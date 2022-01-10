/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../config/config_color.dart';
import 'logout_modal_service.dart';
import 'ui/logout_modal_layout.dart';

class LogoutModalPresenter {
  final LogoutModalService service;

  LogoutModalPresenter(this.service);

  ChangeNotifierProvider<LogoutModalService> render() {
    return ChangeNotifierProvider.value(
        value: service, child: LogoutModalLayout());
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
