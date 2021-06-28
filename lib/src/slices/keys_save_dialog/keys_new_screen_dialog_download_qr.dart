/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sizer/sizer.dart';

class KeysNewScreenDialogDownloadQr extends StatelessWidget {
  static final double _fontSize = 4.w;
  final keyData;

  const KeysNewScreenDialogDownloadQr(this.keyData);

  @override
  Widget build(BuildContext context) {
    Widget screen = Column(children: [
      Container(
          height: 50.w,
          width: 50.w,
          child: QrImage(
              version: QrVersions.auto,
              data: keyData,
              errorStateBuilder: (context, error) {
                Sentry.captureException(
                    Exception(
                        "Failed to generate QR code: " + error.toString()),
                    stackTrace: StackTrace.current);
                return Center(
                  child: Text("Failed to generate QR code. Contact Support.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: _fontSize,
                          color: ConfigColor.orange,
                          fontWeight: FontWeight.bold)),
                );
              })),
    ]);
    return screen;
  }
}
