/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../config/config_color.dart';
import 'keys_modal_service.dart';
import 'ui/keys_modal_layout.dart';

class KeysModalPresenter {
  final KeysModalService service;

  KeysModalPresenter(this.service);

  ChangeNotifierProvider<KeysModalService> render() {
    return ChangeNotifierProvider.value(
        value: service, child: KeysModalLayout());
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
