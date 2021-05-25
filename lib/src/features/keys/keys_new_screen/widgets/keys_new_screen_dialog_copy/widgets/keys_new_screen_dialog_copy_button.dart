/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/features/keys/keys_new_screen/widgets/keys_new_screen_dialog_copy/cubit/keys_new_screen_dialog_copy_button_cubit.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KeysNewScreenDialogCopyButton extends StatelessWidget {
  static const String _buttonText = "COPY";
  static final double _borderRadius = 2 * PlatformRelativeSize.blockHorizontal;
  static final double _paddingHorizontal =
      2 * PlatformRelativeSize.blockHorizontal;
  static final double _paddingHorizontalIcon =
      1 * PlatformRelativeSize.blockHorizontal;

  final String? value;
  final Function() onPressed;

  KeysNewScreenDialogCopyButton(this.value, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => KeysNewScreenDialogCopyButtonCubit(),
        child: BlocBuilder<KeysNewScreenDialogCopyButtonCubit,
            KeysNewScreenDialogCopyButtonState>(
          builder:
              (BuildContext context, KeysNewScreenDialogCopyButtonState state) {
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: ConfigColor.white,
                  border: Border.all(
                    color: ConfigColor.silverChalice,
                  ),
                  borderRadius:
                      BorderRadius.all(Radius.circular(_borderRadius))),
              child: Row(
                children: [_text(), _button(context, state)],
              ),
            );
          },
        ));
  }

  Widget _text() {
    return Expanded(
        child: Container(
            padding: EdgeInsets.only(left: 8),
            child: Text(value!,
                overflow: TextOverflow.ellipsis, textAlign: TextAlign.left)));
  }

  Widget _button(
      BuildContext context, KeysNewScreenDialogCopyButtonState state) {
    return Container(
        decoration: BoxDecoration(
            border: Border(left: BorderSide(color: ConfigColor.silverChalice))),
        child: Container(
            decoration: BoxDecoration(
              color: ConfigColor.gallery,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius)),
            ),
            child: TextButton(
                onPressed: () {
                  BlocProvider.of<KeysNewScreenDialogCopyButtonCubit>(context)
                      .copied(value!);
                  onPressed();
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
                                            is KeysNewScreenDialogCopyButtonSuccess
                                        ? ConfigColor.jade
                                        : ConfigColor.mardiGras)),
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: _paddingHorizontalIcon),
                                child: state
                                        is KeysNewScreenDialogCopyButtonSuccess
                                    ? Icon(Icons.check, color: ConfigColor.jade)
                                    : Image(
                                        image: AssetImage(
                                            "res/images/icon-copy.png")))
                          ],
                        ))))));
  }
}
