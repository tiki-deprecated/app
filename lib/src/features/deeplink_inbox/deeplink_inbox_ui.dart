/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/constants/constant_colors.dart';
import 'package:app/src/constants/constant_strings.dart';
import 'package:app/src/features/deeplink_inbox/deeplink_inbox_bloc_provider.dart';
import 'package:app/src/screens/screen_keys_create.dart';
import 'package:app/src/utilities/relative_size.dart';
import 'package:app/src/utilities/utility_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'deeplink_inbox_bloc.dart';

class DeeplinkInboxUI extends StatelessWidget {
  static final double _heightButton = 8 * RelativeSize.safeBlockVertical;
  static final double _widthButton = 50 * RelativeSize.safeBlockHorizontal;
  static final double _fSizeButton = 6 * RelativeSize.safeBlockHorizontal;

  @override
  Widget build(BuildContext context) {
    DeeplinkInboxBloc deeplinkInboxBloc =
        DeeplinkInboxBlocProvider.of(context).bloc;
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(_heightButton))),
            primary: ConstantColors.mardiGras),
        child: Container(
            width: _widthButton,
            height: _heightButton,
            child: Center(
                child: Text(ConstantStrings.loginEmailButton,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: _fSizeButton,
                        letterSpacing:
                            0.05 * RelativeSize.safeBlockHorizontal)))),
        onLongPress: () {
          Navigator.push(context, platformPageRoute(ScreenKeysCreate()));
        },
        onPressed: () => deeplinkInboxBloc.openInbox());
  }
}
