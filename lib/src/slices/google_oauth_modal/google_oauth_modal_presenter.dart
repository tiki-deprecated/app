/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../config/config_color.dart';
import 'google_oauth_modal_service.dart';
import 'ui/google_oauth_modal_layout.dart';

class GoogleOauthModalPresenter {
  final GoogleOauthModalService service;

  GoogleOauthModalPresenter(this.service);

  ChangeNotifierProvider<GoogleOauthModalService> render() {
    return ChangeNotifierProvider.value(
        value: service, child: GoogleOauthModalLayout());
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
