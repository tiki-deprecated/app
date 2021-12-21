/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../config/config_color.dart';
import 'support_modal_service.dart';
import 'ui/support_modal_layout.dart';

class SupportModalPresenter {
  final SupportModalService service;

  SupportModalPresenter(this.service);

  ChangeNotifierProvider<SupportModalService> render() {
    return ChangeNotifierProvider.value(
        value: service, child: SupportModalLayout());
  }

  Future<void> showModal(BuildContext context) {
    return showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        backgroundColor: ConfigColor.greyTwo,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(6.h))),
        builder: (BuildContext context) => render());
  }
}
