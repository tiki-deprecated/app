/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:io';

import 'package:app/src/configs/config_colors.dart';
import 'package:app/src/configs/config_strings.dart';
import 'package:app/src/platform/platform_page_route.dart';
import 'package:app/src/platform/platform_relative_size.dart';
import 'package:app/src/repos/repo_amplitude/repo_amplitude_bloc_provider.dart';
import 'package:app/src/repos/repo_amplitude/repo_amplitude_const.dart'
    as AmpConst;
import 'package:app/src/ui/ui_magiclink_send/ui_magic_link_bloc.dart';
import 'package:app/src/ui/ui_magiclink_send/ui_magic_link_bloc_provider.dart';
import 'package:app/src/ui/ui_magiclink_send/ui_magic_link_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UIMagicLinkView extends StatefulWidget {
  final Widget _onSubmit;

  UIMagicLinkView(this._onSubmit);

  @override
  _UIMagicLinkView createState() => _UIMagicLinkView(_onSubmit);
}

class _UIMagicLinkView extends State<UIMagicLinkView> {
  static final double _hPadding = 4 * PlatformRelativeSize.safeBlockHorizontal;
  static final double _vPadding = 2 * PlatformRelativeSize.safeBlockVertical;
  static final double _fSizeInput =
      5 * PlatformRelativeSize.safeBlockHorizontal;
  static final double _fSizeError =
      4 * PlatformRelativeSize.safeBlockHorizontal;
  static final double _fSizeButton =
      6 * PlatformRelativeSize.safeBlockHorizontal;
  static final double _vMarginButton =
      4 * PlatformRelativeSize.safeBlockVertical;
  static final double _widthButton =
      50 * PlatformRelativeSize.safeBlockHorizontal;
  static final double _heightButton =
      8 * PlatformRelativeSize.safeBlockVertical;

  final Widget _onSubmit;
  UIMagicLinkBloc _magicLinkBloc;

  _UIMagicLinkView(this._onSubmit);

  @override
  Widget build(BuildContext context) {
    _magicLinkBloc = UIMagicLinkBlocProvider.of(context).bloc;
    return StreamBuilder(
        stream: _magicLinkBloc.observableModel,
        initialData: UIMagicLinkModel(isError: false, isReady: false),
        builder: (context, AsyncSnapshot<UIMagicLinkModel> snapshot) {
          return Row(children: [
            Expanded(
              child: Column(
                children: [
                  Platform.isIOS ? _iosInput() : _androidInput(),
                  _error(isError: snapshot.data.isError),
                  _submit(context, isReady: snapshot.data.isReady),
                ],
              ),
            ),
          ]);
        });
  }

  Widget _iosInput({bool isError = false}) {
    return CupertinoTextField(
      padding: EdgeInsets.symmetric(horizontal: _hPadding, vertical: _vPadding),
      placeholder: ConfigStrings.loginEmailPlaceholder,
      autocorrect: false,
      autofocus: true,
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
                  color:
                      isError ? ConfigColors.grenadier : ConfigColors.mardiGras,
                  width: 2,
                  style: BorderStyle.solid))),
      onChanged: (input) => _magicLinkBloc.checkInput(input),
    );
  }

  Widget _androidInput({bool isError = false}) {
    return TextField(
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: _fSizeInput),
      cursorColor: ConfigColors.orange,
      autocorrect: false,
      autofocus: true,
      decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: _hPadding, vertical: _vPadding),
          hintText: ConfigStrings.loginEmailPlaceholder,
          hintStyle: TextStyle(
              color: ConfigColors.gray,
              fontWeight: FontWeight.bold,
              fontSize: _fSizeInput),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color:
                      isError ? ConfigColors.grenadier : ConfigColors.mardiGras,
                  width: 2,
                  style: BorderStyle.solid)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color:
                      isError ? ConfigColors.grenadier : ConfigColors.mardiGras,
                  width: 2,
                  style: BorderStyle.solid))),
      onChanged: (input) => _magicLinkBloc.checkInput(input),
    );
  }

  Widget _error({bool isError = false}) {
    return Container(
        height: _fSizeError * 1.2,
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              ConfigStrings.loginError,
              style: TextStyle(
                  fontSize: isError ? _fSizeError : 0,
                  fontWeight: FontWeight.w500,
                  color:
                      isError ? ConfigColors.grenadier : ConfigColors.serenade),
            )));
  }

  Widget _submit(BuildContext context, {bool isReady = false}) {
    return Container(
        margin: EdgeInsets.only(top: _vMarginButton),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(_vMarginButton))),
              primary: isReady ? ConfigColors.mardiGras : ConfigColors.mamba),
          onPressed: () {
            if (isReady) {
              _magicLinkBloc.send().then((success) {
                RepoAmplitudeBlocProvider.of(context).bloc.event(
                    AmpConst.requestOtpE,
                    properties: {AmpConst.requestOtpPSuccess: success});
                if (success)
                  Navigator.push(context, platformPageRoute(_onSubmit));
              });
            }
          },
          child: Container(
            width: _widthButton,
            height: _heightButton,
            child: Center(
              child: Text(
                ConfigStrings.loginSubmit,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: _fSizeButton,
                    letterSpacing:
                        0.05 * PlatformRelativeSize.safeBlockHorizontal,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _magicLinkBloc.dispose();
    super.dispose();
  }
}
