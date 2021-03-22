/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:io';

import 'package:app/src/constants/constant_colors.dart';
import 'package:app/src/constants/constant_sizes.dart';
import 'package:app/src/constants/constant_strings.dart';
import 'package:app/src/utilities/platform_scaffold.dart';
import 'package:app/src/utilities/relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScreenKeysLoad extends PlatformScaffold {
  @override
  Scaffold androidScaffold(BuildContext context) {
    return Scaffold(
      body: ScreenKeysLoadStatefulWidget(),
    );
  }

  @override
  CupertinoPageScaffold iosScaffold(BuildContext context) {
    return CupertinoPageScaffold(
      child: ScreenKeysLoadStatefulWidget(),
    );
  }
}

class ScreenKeysLoadStatefulWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScreenKeysLoadState();
}

class _ScreenKeysLoadState extends State<ScreenKeysLoadStatefulWidget> {
  static final double _hPadding =
      ConstantSizes.hPadding * RelativeSize.safeBlockHorizontal;
  static final double _vMarginStart = 15 * RelativeSize.safeBlockVertical;
  static final double _vMargin = 2.5 * RelativeSize.safeBlockVertical;
  static final double _fSizeTitle = 10 * RelativeSize.safeBlockHorizontal;
  static final double _fSizeSubtitle = 5 * RelativeSize.safeBlockHorizontal;
  static final double _fSizeButton = 5 * RelativeSize.safeBlockHorizontal;
  static final double _fSizeInput = 5 * RelativeSize.safeBlockHorizontal;
  static final double _heightButton = 8 * RelativeSize.safeBlockVertical;
  static final double _widthButton = 50 * RelativeSize.safeBlockHorizontal;
  static final double _hPaddingButton = 5 * RelativeSize.safeBlockHorizontal;

  static final double _hPaddingTextField = 4 * RelativeSize.safeBlockHorizontal;
  static final double _vPaddingTextField = 2 * RelativeSize.safeBlockVertical;

  ScrollPhysics _scrollPhysics = NeverScrollableScrollPhysics();

  @override
  Widget build(BuildContext context) {
    //TODO fix scrolling mess. It should not display behind status icons, it should auto-scroll to bottom. It's very messy code.
    return GestureDetector(
      child: Stack(
        children: [
          _background(),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                physics: _scrollPhysics,
                child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: _foreground(context)),
              );
            },
          )
        ],
      ),
      onTap: () {
        FocusScope.of(context).unfocus();
        _scrollPhysics = NeverScrollableScrollPhysics();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _background() {
    return Stack(
      children: [
        Container(
          color: ConstantColors.serenade,
        ),
        Container(
            child: Align(
                alignment: Alignment.topRight,
                child: Image(image: AssetImage('res/images/keys-blob.png')))),
      ],
    );
  }

  Widget _foreground(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: _hPadding, right: _hPadding),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        _title(),
        _subtitle(),
        _loadButton(ConstantStrings.keysLoadButtonUpload,
            'res/images/icon-upload-image.png', () {}),
        _loadButton(ConstantStrings.keysLoadButtonScan,
            'res/images/icon-qr-code.png', () {}),
        _divider(),
        _textInput(ConstantStrings.keysLoadPlaceholderID, (input) {
          print(input);
        }),
        _textInput(ConstantStrings.keysLoadPlaceholderKey, (input) {}),
        _submit(context)
      ]),
    );
  }

  Widget _title() {
    return Container(
        margin: EdgeInsets.only(top: _vMarginStart),
        child: Align(
            alignment: Alignment.center,
            child: Text(ConstantStrings.keysLoadTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Koara',
                    fontSize: _fSizeTitle,
                    fontWeight: FontWeight.bold,
                    color: ConstantColors.mardiGras))));
  }

  Widget _subtitle() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: _vMargin),
        child: Align(
            alignment: Alignment.center,
            child: Text(ConstantStrings.keysLoadSubtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: _fSizeSubtitle,
                    fontWeight: FontWeight.w600,
                    color: ConstantColors.emperor))));
  }

  //TODO move to BLOC
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

  //TODO move to BLOC
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
          onPressed: () {},
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

  Widget _textInput(String placeholder, Function(String) onChanged) {
    return Container(
        margin: EdgeInsets.only(top: _vMargin),
        child: Platform.isIOS
            ? _iosInput(ConstantStrings.keysLoadPlaceholderID, onChanged)
            : _androidInput(ConstantStrings.keysLoadPlaceholderID, onChanged));
  }

  //TODO move to BLOC
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
      onTap: () {
        _scrollPhysics = AlwaysScrollableScrollPhysics();
      },
    );
  }

  //TODO move to BLOC
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
}
