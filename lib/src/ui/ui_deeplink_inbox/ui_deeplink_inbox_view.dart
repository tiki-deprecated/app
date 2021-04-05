/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/configs/config_colors.dart';
import 'package:app/src/configs/config_strings.dart';
import 'package:app/src/platform/platform_page_route.dart';
import 'package:app/src/platform/platform_relative_size.dart';
import 'package:app/src/screens/screen_keys_create.dart';
import 'package:app/src/ui/ui_deeplink_inbox/ui_deeplink_inbox_bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ui_deeplink_inbox_bloc.dart';

class UIDeeplinkInboxView extends StatelessWidget {
  static final double _heightButton =
      8 * PlatformRelativeSize.safeBlockVertical;
  static final double _widthButton =
      50 * PlatformRelativeSize.safeBlockHorizontal;
  static final double _fSizeButton =
      6 * PlatformRelativeSize.safeBlockHorizontal;

  @override
  Widget build(BuildContext context) {
    UIDeeplinkInboxBloc deeplinkInboxBloc =
        UIDeeplinkInboxBlocProvider.of(context).bloc;
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(_heightButton))),
            primary: ConfigColors.mardiGras),
        child: Container(
            width: _widthButton,
            height: _heightButton,
            child: Center(
                child: Text(ConfigStrings.loginEmailButton,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: _fSizeButton,
                        letterSpacing:
                            0.05 * PlatformRelativeSize.safeBlockHorizontal)))),
        onLongPress: () {
          Navigator.push(context, platformPageRoute(ScreenKeysCreate()));
        },
        onPressed: () => deeplinkInboxBloc.openInbox());
  }
}
