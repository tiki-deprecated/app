/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:io';

import 'package:app/src/constants/constant_colors.dart';
import 'package:app/src/constants/constant_strings.dart';
import 'package:app/src/features/security_keys_load/security_keys_load_bloc.dart';
import 'package:app/src/features/security_keys_load/security_keys_load_bloc_provider.dart';
import 'package:app/src/utilities/relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecurityKeysLoadUI extends StatefulWidget {
  final Function _onComplete;

  SecurityKeysLoadUI(this._onComplete);

  @override
  State<StatefulWidget> createState() => _SecurityKeysLoadUI(_onComplete);
}

class _SecurityKeysLoadUI extends State<SecurityKeysLoadUI> {
  static final double _vMargin = 2.5 * RelativeSize.safeBlockVertical;
  static final double _fSizeButton = 5 * RelativeSize.safeBlockHorizontal;
  static final double _fSizeInput = 5 * RelativeSize.safeBlockHorizontal;
  static final double _heightButton = 8 * RelativeSize.safeBlockVertical;
  static final double _widthButton = 50 * RelativeSize.safeBlockHorizontal;
  static final double _hPaddingButton = 5 * RelativeSize.safeBlockHorizontal;
  static final double _hPaddingTextField = 4 * RelativeSize.safeBlockHorizontal;
  static final double _vPaddingTextField = 2 * RelativeSize.safeBlockVertical;

  final Function _onComplete;
  SecurityKeysLoadBloc _securityKeysLoadBloc;
  //TODO move this into model
  String id;
  String dataKey;
  String signKey;

  _SecurityKeysLoadUI(this._onComplete);

  @override
  Widget build(BuildContext context) {
    _securityKeysLoadBloc = SecurityKeysLoadBlocProvider.of(context).bloc;
    return Column(children: [
      //TODO load files
      /*_loadButton(ConstantStrings.keysLoadButtonUpload,
          'res/images/icon-upload-image.png', () {
        _securityKeysLoadBloc.loadFromFile();
      }),*/
      _loadButton(
          ConstantStrings.keysLoadButtonScan, 'res/images/icon-qr-code.png',
          () {
        _securityKeysLoadBloc.scan().then((keys) {
          if (keys != null) this._onComplete(keys);
        });
      }),
      _divider(),
      _textInput(ConstantStrings.keysLoadPlaceholderID, (input) {
        id = input;
      }),
      _textInput(ConstantStrings.keysLoadPlaceholderDataKey, (input) {
        dataKey = input;
      }),
      _textInput(ConstantStrings.keysLoadPlaceholderSignKey, (input) {
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
                    primary: ConstantColors.mardiGras),
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
                                      RelativeSize.safeBlockHorizontal))),
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
      color: ConstantColors.silverChalice,
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
          color: ConstantColors.gray,
          fontWeight: FontWeight.bold,
          fontSize: _fSizeInput),
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: _fSizeInput),
      cursorColor: ConstantColors.orange,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
                  color: ConstantColors.mardiGras,
                  width: 2,
                  style: BorderStyle.solid))),
      onChanged: onChanged,
    );
  }

  Widget _androidInput(String placeholder, Function(String) onChanged) {
    return TextField(
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: _fSizeInput),
      cursorColor: ConstantColors.orange,
      autocorrect: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              horizontal: _hPaddingTextField, vertical: _vPaddingTextField),
          hintText: placeholder,
          hintStyle: TextStyle(
              color: ConstantColors.gray,
              fontWeight: FontWeight.bold,
              fontSize: _fSizeInput),
          fillColor: Colors.white,
          border: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: ConstantColors.mardiGras,
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
              primary:
                  isReady ? ConstantColors.mardiGras : ConstantColors.mamba),
          onPressed: () {
            _securityKeysLoadBloc.manual(id, dataKey, signKey).then((keys) {
              if (keys != null) _onComplete(keys);
            });
          },
          child: Container(
            width: _widthButton,
            height: _heightButton,
            child: Center(
              child: Text(ConstantStrings.keysLoadButtonSubmit,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: _fSizeButton,
                      letterSpacing: 0.05 * RelativeSize.safeBlockHorizontal,
                      fontWeight: FontWeight.w700)),
            ),
          ),
        ));
  }
}
