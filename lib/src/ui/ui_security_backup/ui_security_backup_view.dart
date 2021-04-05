/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:developer';

import 'package:app/src/configs/config_colors.dart';
import 'package:app/src/configs/config_strings.dart';
import 'package:app/src/platform/platform_relative_size.dart';
import 'package:app/src/ui/ui_security_backup/ui_security_backup_bloc.dart';
import 'package:app/src/ui/ui_security_backup/ui_security_backup_bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UISecurityBackupView extends StatefulWidget {
  final Function _onSave;

  UISecurityBackupView(this._onSave);

  @override
  State<StatefulWidget> createState() => _UISecurityBackupView(_onSave);
}

class _UISecurityBackupView extends State<UISecurityBackupView> {
  static final double _fSizeCopy =
      3.5 * PlatformRelativeSize.safeBlockHorizontal;
  static final double _fSizeFailed =
      4 * PlatformRelativeSize.safeBlockHorizontal;
  static final double _vMarginButton =
      3 * PlatformRelativeSize.safeBlockVertical;
  static final double _hPaddingButton =
      2 * PlatformRelativeSize.safeBlockHorizontal;
  static final double _vMarginCopy = 1 * PlatformRelativeSize.safeBlockVertical;
  static final double _fSizeButton =
      6 * PlatformRelativeSize.safeBlockHorizontal;
  static final double _heightButton =
      8 * PlatformRelativeSize.safeBlockVertical;
  static final double _heightQR = 30 * PlatformRelativeSize.safeBlockVertical;
  static final double _widthButton =
      50 * PlatformRelativeSize.safeBlockHorizontal;

  final Function _onSave;

  UISecurityBackupBloc _securityKeysBackupBloc;
  GlobalKey _qrCodeKey;

  _UISecurityBackupView(this._onSave);

  @override
  Widget build(BuildContext context) {
    _securityKeysBackupBloc = UISecurityBackupBlocProvider.of(context).bloc;
    _qrCodeKey = GlobalKey();
    return Column(children: [
      Container(
          child: RepaintBoundary(
              key: _qrCodeKey,
              child: QrImage(
                  version: QrVersions.auto,
                  data: _securityKeysBackupBloc.qrCodeData(),
                  size: _heightQR,
                  errorStateBuilder: (cxt, err) {
                    log("Unable to generate QR code", error: err);
                    return Center(
                      child: Text(
                          "Failed to generate QR code. Contact Support.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: _fSizeFailed,
                              color: ConfigColors.orange,
                              fontWeight: FontWeight.bold)),
                    );
                  }))),
      _copyField(ConfigStrings.keysID, _securityKeysBackupBloc.keys.address),
      _copyField(ConfigStrings.keysDataKey,
          _securityKeysBackupBloc.keys.dataKey.encodedPrivate),
      _copyField(ConfigStrings.keysSignKey,
          _securityKeysBackupBloc.keys.signKey.encodedPrivate),
      _saveButton(context)
    ]);
  }

  Widget _copyField(String label, String value) {
    return Container(
      margin: EdgeInsets.only(top: _vMarginCopy),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: ConfigColors.silverChalice,
          ),
          borderRadius: BorderRadius.all(Radius.circular(_fSizeCopy * 0.4))),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: _hPaddingButton),
            child: Text(label + " : ",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: ConfigColors.gray,
                    fontSize: _fSizeCopy,
                    fontWeight: FontWeight.bold)),
          ),
          Flexible(
              child: Container(
                  child: Text(value,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: ConfigColors.stratos,
                          fontSize: _fSizeCopy,
                          fontWeight: FontWeight.bold)))),
          Container(
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(color: ConfigColors.silverChalice))),
              child: Container(
                  decoration: BoxDecoration(
                    color: ConfigColors.gallery,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(_fSizeCopy * 0.4),
                        bottomRight: Radius.circular(_fSizeCopy * 0.4)),
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
                                  horizontal: _hPaddingButton),
                              child: Row(
                                children: [
                                  Text(ConfigStrings.keysCopy,
                                      style: TextStyle(
                                          color: ConfigColors.stratos,
                                          fontSize: _fSizeCopy,
                                          fontWeight: FontWeight.bold)),
                                  Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: _hPaddingButton * 0.5),
                                      child: Image(
                                          image: AssetImage(
                                              "res/images/icon-copy.png")))
                                ],
                              ))))))
        ],
      ),
    );
  }

  Widget _saveButton(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: _vMarginButton),
        child: Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(_vMarginButton * 2))),
                  primary: ConfigColors.mardiGras),
              child: Container(
                  width: _widthButton,
                  height: _heightButton,
                  child: Center(
                      child: Text(ConfigStrings.keysSave,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: _fSizeButton,
                              letterSpacing: 0.05 *
                                  PlatformRelativeSize.safeBlockHorizontal)))),
              onPressed: () {
                _securityKeysBackupBloc.download(_qrCodeKey);
                _onSave(context);
              },
            )));
  }
}
