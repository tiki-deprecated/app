/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../config/config_color.dart';
import 'support_screen_service.dart';
import 'ui/support_screen_layout.dart';

class SupportScreenPresenter {
  final SupportScreenService service;

  SupportScreenPresenter(this.service);

  ChangeNotifierProvider<SupportScreenService> render() {
    return ChangeNotifierProvider.value(
        value: service, child: SupportScreenLayout());
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
