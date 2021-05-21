/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/features/keys/keys_referral/bloc/keys_referral_cubit.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenReferCode extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenReferCode();
}

class _HomeScreenReferCode extends State<HomeScreenReferCode> {
  static const String _text = "YOUR CODE";
  static final double _fontSize = 4 * PlatformRelativeSize.blockHorizontal;
  static final double _marginLeft = 1 * PlatformRelativeSize.blockHorizontal;
  static final double _marginRight = 3 * PlatformRelativeSize.blockHorizontal;
  static final double _marginVertical =
      1.5 * PlatformRelativeSize.blockVertical;
  static final double _borderRadius = 1.5 * PlatformRelativeSize.blockVertical;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<KeysReferralCubit>(context).getLink();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeysReferralCubit, KeysReferralState>(
        builder: (BuildContext context, KeysReferralState state) {
      return _button(state.link);
    });
  }

  Widget _button(Uri? link) {
    return OutlinedButton(
        onPressed: () async {
          Clipboard.setData(new ClipboardData(text: link.toString()));
        },
        style: OutlinedButton.styleFrom(
            side: BorderSide(color: ConfigColor.alto),
            primary: ConfigColor.gray,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(_borderRadius)))),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(_text,
              style: TextStyle(
                  fontSize: _fontSize,
                  fontWeight: FontWeight.bold,
                  color: ConfigColor.gray)),
          Container(
              margin: EdgeInsets.only(
                  left: _marginLeft,
                  right: _marginRight,
                  top: _marginVertical,
                  bottom: _marginVertical),
              child: Text(
                  link
                      .toString()
                      .replaceAll(new RegExp(r'https://mytiki.app/'), ''),
                  style: TextStyle(
                      fontSize: _fontSize,
                      fontWeight: FontWeight.bold,
                      color: ConfigColor.stratos))),
          HelperImage("icon-copy"),
        ]));
  }
}
