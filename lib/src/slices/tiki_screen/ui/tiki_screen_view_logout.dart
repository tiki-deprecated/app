/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/app/app_service.dart';
import 'package:app/src/slices/tiki_screen/tiki_screen_service.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:app/src/widgets/components/tiki_inputs/tiki_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TikiScreenViewLogout extends StatelessWidget {
  static const String _text = "Log out";

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<TikiScreenService>(context);
    return Container(
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.symmetric(vertical: service.presenter.marginVerticalLogOut),
        child: TikiTextButton(
          _text,
          service.controller.logout,
          fontSize: 4,
          fontWeight: FontWeight.bold,
          color: ConfigColor.grenadier,
          trailing: Padding(
          padding: EdgeInsets.only(left: 16),
          child: HelperImage("icon-logout")),
    ));
  }
}
