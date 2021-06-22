/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/features/keys/keys_restore_screen/bloc/keys_restore_screen_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class KeysRestoreScreenSubmit extends StatelessWidget {
  static const String _text = "SUBMIT";
  static final double _letterSpacing = 0.05.w;
  static final double _fontSize = 6.w;
  static final double _marginHorizontal = 20.w;
  static final double _marginVertical = 2.5.h;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeysRestoreScreenBloc, KeysRestoreScreenState>(
        builder: (BuildContext context, KeysRestoreScreenState state) {
      return _button(context,
          state is KeysRestoreScreenInProgress ? state.isValid : false);
    });
  }

  Widget _button(BuildContext context, bool isActive) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.h))),
            primary: isActive ? ConfigColor.mardiGras : ConfigColor.mamba),
        child: Wrap(
          direction: Axis.vertical,
          children: [
            Container(
                margin: EdgeInsets.symmetric(
                    vertical: _marginVertical, horizontal: _marginHorizontal),
                child: Center(
                    child: Text(_text,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: _fontSize,
                          letterSpacing: _letterSpacing,
                        ))))
          ],
        ),
        onPressed: () {
          if (isActive) {
            BlocProvider.of<KeysRestoreScreenBloc>(context)
                .add(KeysRestoreScreenSubmitted());
          }
        });
  }
}
