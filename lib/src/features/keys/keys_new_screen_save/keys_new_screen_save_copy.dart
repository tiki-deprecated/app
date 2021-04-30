/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/config/config_string.dart';
import 'package:app/src/features/keys/keys_new/keys_new_bloc.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum KeysNewScreenSaveCopyEnum { id, data, sign }

class KeysNewScreenSaveCopy extends StatelessWidget {
  static final double _fontSize = 4.5 * PlatformRelativeSize.blockHorizontal;
  static final double _borderRadius = 2 * PlatformRelativeSize.blockHorizontal;
  static final double _paddingLeft = 2 * PlatformRelativeSize.blockHorizontal;
  static final double _paddingHorizontal =
      2 * PlatformRelativeSize.blockHorizontal;
  static final double _paddingHorizontalIcon =
      1 * PlatformRelativeSize.blockHorizontal;

  final KeysNewScreenSaveCopyEnum _e;

  KeysNewScreenSaveCopy(this._e);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeysNewBloc, KeysNewState>(
        builder: (BuildContext context, KeysNewState state) {
      switch (_e) {
        case KeysNewScreenSaveCopyEnum.id:
          return _copy(ConfigString.keysNew.copyId, state.address);
        case KeysNewScreenSaveCopyEnum.data:
          return _copy(ConfigString.keysNew.copyDataKey, state.dataPrivate);
        case KeysNewScreenSaveCopyEnum.sign:
          return _copy(ConfigString.keysNew.copySignKey, state.signPrivate);
        default:
          return _copy("ERR", "CONTACT SUPPORT");
      }
    });
  }

  Widget _copy(String label, String value) {
    return Container(
      decoration: BoxDecoration(
          color: ConfigColor.white,
          border: Border.all(
            color: ConfigColor.silverChalice,
          ),
          borderRadius: BorderRadius.all(Radius.circular(_borderRadius))),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: _paddingLeft),
            child: Text(label + " : ",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: ConfigColor.gray,
                    fontSize: _fontSize,
                    fontWeight: FontWeight.bold)),
          ),
          Flexible(
              child: Container(
                  child: Text(value,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: ConfigColor.stratos,
                          fontSize: _fontSize,
                          fontWeight: FontWeight.bold)))),
          Container(
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(color: ConfigColor.silverChalice))),
              child: Container(
                  decoration: BoxDecoration(
                    color: ConfigColor.gallery,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(_borderRadius),
                        bottomRight: Radius.circular(_borderRadius)),
                  ),
                  child: TextButton(
                      onPressed: () {
                        Clipboard.setData(new ClipboardData(text: value));
                      },
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero)),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: _paddingHorizontal),
                              child: Row(
                                children: [
                                  Text(ConfigString.keysNew.copyButton,
                                      style: TextStyle(
                                          color: ConfigColor.stratos,
                                          fontSize: _fontSize,
                                          fontWeight: FontWeight.bold)),
                                  Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: _paddingHorizontalIcon),
                                      child: HelperImage("icon-copy"))
                                ],
                              ))))))
        ],
      ),
    );
  }
}
