/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class KeysNewScreenDialogDownloadQr extends StatelessWidget {
  static final double _fontSize = 4 * PlatformRelativeSize.blockHorizontal;
  final keyData;

  const KeysNewScreenDialogDownloadQr(this.keyData);

  @override
  Widget build(BuildContext context) {
    Widget screen = Column(children: [
      Container(
          height: 50 * PlatformRelativeSize.blockHorizontal,
          width: 50 * PlatformRelativeSize.blockHorizontal,
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
