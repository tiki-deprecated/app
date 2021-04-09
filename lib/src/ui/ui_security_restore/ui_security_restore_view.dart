/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:io';

import 'package:app/src/configs/config_colors.dart';
import 'package:app/src/configs/config_strings.dart';
import 'package:app/src/platform/platform_relative_size.dart';
import 'package:app/src/ui/ui_security_restore/ui_security_restore_bloc.dart';
import 'package:app/src/ui/ui_security_restore/ui_security_restore_bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UISecurityRestoreView extends StatefulWidget {
  final Function _onComplete;

  UISecurityRestoreView(this._onComplete);

  @override
  State<StatefulWidget> createState() => _UISecurityRestoreView(_onComplete);
}

class _UISecurityRestoreView extends State<UISecurityRestoreView> {
  static final double _vMargin = 2.5 * PlatformRelativeSize.safeBlockVertical;
  static final double _fSizeButton =
      5 * PlatformRelativeSize.safeBlockHorizontal;
  static final double _fSizeInput =
      5 * PlatformRelativeSize.safeBlockHorizontal;
  static final double _heightButton =
      8 * PlatformRelativeSize.safeBlockVertical;
  static final double _widthButton =
      50 * PlatformRelativeSize.safeBlockHorizontal;
  static final double _hPaddingButton =
      5 * PlatformRelativeSize.safeBlockHorizontal;
  static final double _hPaddingTextField =
      4 * PlatformRelativeSize.safeBlockHorizontal;
  static final double _vPaddingTextField =
      2 * PlatformRelativeSize.safeBlockVertical;

  final Function _onComplete;
  UISecurityRestoreBloc _securityKeysLoadBloc;
  //TODO move this into model
  String id;
  String dataKey;
  String signKey;

  _UISecurityRestoreView(this._onComplete);

  @override
  Widget build(BuildContext context) {
    _securityKeysLoadBloc = UISecurityRestoreBlocProvider.of(context).bloc;
    return Column(children: [
      //TODO load files
      /*_loadButton(ConfigStrings.keysLoadButtonUpload,
          'res/images/icon-upload-image.png', () {
        _securityKeysLoadBloc.loadFromFile();
      }),*/
      _loadButton(
          ConfigStrings.keysLoadButtonScan, 'res/images/icon-qr-code.png', () {
        _securityKeysLoadBloc.scan().then((keys) {
          if (keys != null) this._onComplete(keys);
        });
      }),
      _divider(),
      _textInput(ConfigStrings.keysLoadPlaceholderID, (input) {
        id = input;
      }),
      _textInput(ConfigStrings.keysLoadPlaceholderDataKey, (input) {
        dataKey = input;
      }),
      _textInput(ConfigStrings.keysLoadPlaceholderSignKey, (input) {
        signKey = input;
      }),
      _submit(context, isReady: true)
    ]);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _loadButton(String text, String icon, Function onPressed) {
    return Container(
        margin: EdgeInsets.only(top: _vMargin),
        child: Align(
            alignment: Alignment.center,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(_vMargin * 2))),
                    primary: ConfigColors.mardiGras),
                child: Container(
                    width: _widthButton,
                    height: _heightButton,
                    padding: EdgeInsets.symmetric(horizontal: _hPaddingButton),
                    child: Row(children: [
                      Expanded(
                          child: Text(text,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: _fSizeButton,
                                  letterSpacing: 0.05 *
                                      PlatformRelativeSize
                                          .safeBlockHorizontal))),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Image(image: AssetImage(icon)))
                    ])),
                onPressed: onPressed)));
  }

  Widget _divider() {
    return Container(
      height: 2,
      margin: EdgeInsets.only(top: 2 * _vMargin, bottom: _vMargin),
      color: ConfigColors.silverChalice,
    );
  }

  Widget _textInput(String placeholder, Function(String) onChanged) {
    return Container(
        margin: EdgeInsets.only(top: _vMargin),
        child: Platform.isIOS
            ? _iosInput(placeholder, onChanged)
            : _androidInput(placeholder, onChanged));
  }

  Widget _iosInput(String placeholder, Function(String) onChanged) {
    return CupertinoTextField(
      padding: EdgeInsets.symmetric(
          horizontal: _hPaddingTextField, vertical: _vPaddingTextField),
      placeholder: placeholder,
      autocorrect: false,
      placeholderStyle: TextStyle(
          color: ConfigColors.gray,
          fontWeight: FontWeight.bold,
          fontSize: _fSizeInput),
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: _fSizeInput),
      cursorColor: ConfigColors.orange,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
                  color: ConfigColors.mardiGras,
                  width: 2,
                  style: BorderStyle.solid))),
      onChanged: onChanged,
    );
  }

  Widget _androidInput(String placeholder, Function(String) onChanged) {
    return TextField(
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: _fSizeInput),
      cursorColor: ConfigColors.orange,
      autocorrect: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              horizontal: _hPaddingTextField, vertical: _vPaddingTextField),
          hintText: placeholder,
          hintStyle: TextStyle(
              color: ConfigColors.gray,
              fontWeight: FontWeight.bold,
              fontSize: _fSizeInput),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: ConfigColors.mardiGras,
                  width: 2,
                  style: BorderStyle.solid)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: ConfigColors.mardiGras,
                  width: 2,
                  style: BorderStyle.solid))),
      onChanged: onChanged,
    );
  }

  Widget _submit(BuildContext context, {bool isReady = false}) {
    return Container(
        margin: EdgeInsets.only(top: 2 * _vMargin),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(_vMargin * 4))),
              primary: isReady ? ConfigColors.mardiGras : ConfigColors.mamba),
          onPressed: () {
            _securityKeysLoadBloc.manual(id, dataKey, signKey).then((keys) {
              if (keys != null) _onComplete(keys);
            });
          },
          child: Container(
            width: _widthButton,
            height: _heightButton,
            child: Center(
              child: Text(ConfigStrings.keysLoadButtonSubmit,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: _fSizeButton,
                      letterSpacing:
                          0.05 * PlatformRelativeSize.safeBlockHorizontal,
                      fontWeight: FontWeight.w700)),
            ),
          ),
        ));
  }
}
