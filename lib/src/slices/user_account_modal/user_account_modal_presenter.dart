/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../config/config_color.dart';
import 'ui/user_account_modal_layout.dart';
import 'user_account_modal_service.dart';

class UserAccountModalPresenter {
  final UserAccountModalService service;

  UserAccountModalPresenter(this.service);

  ChangeNotifierProvider<UserAccountModalService> render() {
    return ChangeNotifierProvider.value(
        value: service, child: UserAccountModalLayout());
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
