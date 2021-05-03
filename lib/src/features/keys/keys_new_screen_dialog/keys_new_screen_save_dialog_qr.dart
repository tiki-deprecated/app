/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:io';

import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class KeysNewScreenSaveDialogQr extends StatelessWidget {
  static const String _title = "QR Code";
  static final double _size = 28 * PlatformRelativeSize.blockVertical;

  final String id;
  final String dataKey;
  final String signKey;

  KeysNewScreenSaveDialogQr(this.id, this.dataKey, this.signKey);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS)
      return _ios(context);
    else
      return _android(context);
  }

  AlertDialog _android(BuildContext context) {
    return AlertDialog(title: Text(_title), content: _content());
  }

  CupertinoAlertDialog _ios(BuildContext context) {
    return CupertinoAlertDialog(title: Text(_title), content: _content());
  }

  Widget _content() {
    return Container(
        alignment: Alignment.center,
        height: _size,
        width: _size,
        child: QrImage(
            version: QrVersions.auto,
            data: id + "." + dataKey + "." + signKey,
            errorStateBuilder: (context, error) {
              Sentry.captureException(
                  Exception("Failed to generate QR code: " + error.toString()),
                  stackTrace: StackTrace.current);
              return Center(
                child: Text("Failed to generate QR code. Contact Support."),
              );
            }));
  }
}
