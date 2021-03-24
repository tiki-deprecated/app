/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:developer';

import 'package:app/src/constants/constant_colors.dart';
import 'package:app/src/constants/constant_strings.dart';
import 'package:app/src/features/security_keys_backup/security_keys_backup_bloc.dart';
import 'package:app/src/features/security_keys_backup/security_keys_backup_bloc_provider.dart';
import 'package:app/src/utilities/relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SecurityKeysBackupUI extends StatefulWidget {
  final Function _onSave;

  SecurityKeysBackupUI(this._onSave);

  @override
  State<StatefulWidget> createState() => _SecurityKeysBackupUI(_onSave);
}

class _SecurityKeysBackupUI extends State<SecurityKeysBackupUI> {
  static final double _fSizeCopy = 3.5 * RelativeSize.safeBlockHorizontal;
  static final double _fSizeFailed = 4 * RelativeSize.safeBlockHorizontal;
  static final double _vMarginButton = 3 * RelativeSize.safeBlockVertical;
  static final double _hPaddingButton = 2 * RelativeSize.safeBlockHorizontal;
  static final double _vMarginCopy = 1 * RelativeSize.safeBlockVertical;
  static final double _fSizeButton = 6 * RelativeSize.safeBlockHorizontal;
  static final double _heightButton = 8 * RelativeSize.safeBlockVertical;
  static final double _heightQR = 30 * RelativeSize.safeBlockVertical;
  static final double _widthButton = 50 * RelativeSize.safeBlockHorizontal;

  final Function _onSave;

  SecurityKeysBackupBloc _securityKeysBackupBloc;
  GlobalKey _qrCodeKey;

  _SecurityKeysBackupUI(this._onSave);

  @override
  Widget build(BuildContext context) {
    _securityKeysBackupBloc = SecurityKeysBackupBlocProvider.of(context).bloc;
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
                              color: ConstantColors.orange,
                              fontWeight: FontWeight.bold)),
                    );
                  }))),
      _copyField(ConstantStrings.keysID, _securityKeysBackupBloc.keys.id),
      _copyField(ConstantStrings.keysDataKey,
          _securityKeysBackupBloc.keys.dataKeys.encodedPrivateKey),
      _copyField(ConstantStrings.keysSignKey,
          _securityKeysBackupBloc.keys.signKeys.encodedPrivateKey),
      _saveButton(context)
    ]);
  }

  Widget _copyField(String label, String value) {
    return Container(
      margin: EdgeInsets.only(top: _vMarginCopy),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: ConstantColors.silverChalice,
          ),
          borderRadius: BorderRadius.all(Radius.circular(_fSizeCopy * 0.4))),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: _hPaddingButton),
            child: Text(label + " : ",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: ConstantColors.gray,
                    fontSize: _fSizeCopy,
                    fontWeight: FontWeight.bold)),
          ),
          Flexible(
              child: Container(
                  child: Text(value,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: ConstantColors.stratos,
                          fontSize: _fSizeCopy,
                          fontWeight: FontWeight.bold)))),
          Container(
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(color: ConstantColors.silverChalice))),
              child: Container(
                  decoration: BoxDecoration(
                    color: ConstantColors.gallery,
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
                                  Text(ConstantStrings.keysCopy,
                                      style: TextStyle(
                                          color: ConstantColors.stratos,
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
                  primary: ConstantColors.mardiGras),
              child: Container(
                  width: _widthButton,
                  height: _heightButton,
                  child: Center(
                      child: Text(ConstantStrings.keysSave,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: _fSizeButton,
                              letterSpacing:
                                  0.05 * RelativeSize.safeBlockHorizontal)))),
              onPressed: () {
                _securityKeysBackupBloc.download(_qrCodeKey);
                _onSave(context);
              },
            )));
  }
}
