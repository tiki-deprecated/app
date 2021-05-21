/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/features/keys/keys_new_screen/widgets/keys_new_screen_dialog/bloc/keys_new_screen_save_dialog_bloc.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KeysNewScreenSaveCopyButton extends StatelessWidget {
  static const String _buttonText = "COPY";
  static final double _borderRadius = 2 * PlatformRelativeSize.blockHorizontal;
  static final double _paddingHorizontal =
      2 * PlatformRelativeSize.blockHorizontal;
  static final double _paddingHorizontalIcon =
      1 * PlatformRelativeSize.blockHorizontal;

  final String? value;

  bool copied = false;

  KeysNewScreenSaveCopyButton(this.value);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeysNewScreenSaveDialogCopyBloc,
            KeysNewScreenSaveDialogCopyState>(
        builder: (context, state) => _blocBuilder(context, state));
  }

  Widget _blocBuilder(
      BuildContext context, KeysNewScreenSaveDialogCopyState state) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: ConfigColor.white,
          border: Border.all(
            color: ConfigColor.silverChalice,
          ),
          borderRadius: BorderRadius.all(Radius.circular(_borderRadius))),
      child: Row(
        children: [
          Expanded(
              child: Container(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(value!,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left))),
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
                        KeysNewScreenSaveDialogCopyBloc bloc =
                            BlocProvider.of<KeysNewScreenSaveDialogCopyBloc>(
                                context);
                        bloc.add(KeysNewScreenCopied());
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
                                  Text(_buttonText,
                                      style: TextStyle(
                                          color: state
                                                  is KeysNewScreenSaveDialogCopied
                                              ? ConfigColor.jade
                                              : ConfigColor.mardiGras)),
                                  Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: _paddingHorizontalIcon),
                                      child: state
                                              is KeysNewScreenSaveDialogCopied
                                          ? Icon(Icons.check,
                                              color: ConfigColor.jade)
                                          : Image(
                                              image: AssetImage(
                                                  "res/images/icon-copy.png")))
                                ],
                              ))))))
        ],
      ),
    );
  }
}
