/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:app/src/widgets/components/tiki_big_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class KeysNewScreenQr extends StatelessWidget {
  static final double _fontSize = 4 * PlatformRelativeSize.blockHorizontal;
  final keyData;
  final printCallback;

  const KeysNewScreenQr(this.keyData, this.printCallback);

  @override
  Widget build(BuildContext context) {
    Widget screen = Column(children: [
      Container(
      height: 300,
        width:300,
        child: QrImage(
            version: QrVersions.auto,
            data: keyData,
            errorStateBuilder: (context, error) {
              Sentry.captureException(
                  Exception("Failed to generate QR code: " + error.toString()),
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
            GestureDetector(child: Text("Save"), onTap: printCallback)
    ]);
    return screen;
  }
}
