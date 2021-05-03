/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/features/keys/keys_new_screen/keys_new_screen_bloc.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class KeysNewScreenSaveBk extends StatelessWidget {
  static final double _imageSize = 14 * PlatformRelativeSize.blockHorizontal;
  static final double _fontSizeTitle =
      3.75 * PlatformRelativeSize.blockHorizontal;
  static final double _fontSizeText = 3 * PlatformRelativeSize.blockHorizontal;
  static final double _borderRadius = 2 * PlatformRelativeSize.blockHorizontal;

  final String _image;
  final String _text;
  final String _title;
  KeysNewScreenSaveBk(this._title, this._text, this._image);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeysNewScreenBloc, KeysNewScreenState>(
        builder: (BuildContext context, KeysNewScreenState state) {
      return horizontalButton(context, state);
    });
  }

  Widget horizontalButton(BuildContext context, KeysNewScreenState state) {
    return Container(
        height: 0.5 * _fontSizeText + _imageSize,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(
                    right: 2 * PlatformRelativeSize.blockHorizontal),
                child: TextButton(
                    onPressed: () => onPressed(context, state),
                    style: TextButton.styleFrom(
                        backgroundColor: ConfigColor.macaroniAndCheese,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(_borderRadius)),
                        ),
                        padding: EdgeInsets.all(0)),
                    child: Container(
                        width: _imageSize,
                        height: _imageSize,
                        child: HelperImage(_image)))),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(_title,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: _fontSizeTitle,
                          fontWeight: FontWeight.bold)),
                  Expanded(
                      child: Text(_text,
                          textAlign: TextAlign.left,
                          softWrap: true,
                          style: TextStyle(fontSize: _fontSizeText)))
                ]))
          ],
        ));
  }

  void onPressed(BuildContext context, KeysNewScreenState state);
}
