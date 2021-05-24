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
          width: 300,
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
      downloadBtn(context)
    ]);
    return screen;
  }

  downloadBtn(context) {
    final double _letterSpacing = 0.05 * PlatformRelativeSize.blockHorizontal;
    final double _fontSize = 6 * PlatformRelativeSize.blockHorizontal;
    final double _marginHorizontal = 10 * PlatformRelativeSize.blockHorizontal;
    final double _marginVertical = 2.5 * PlatformRelativeSize.blockVertical;

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
              vertical: _marginVertical, horizontal: _marginHorizontal),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(10 * PlatformRelativeSize.blockVertical))),
          primary: ConfigColor.mardiGras,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(),
            Wrap(
              direction: Axis.vertical,
              children: [
                Container(
                    padding: EdgeInsets.only(
                        right: PlatformRelativeSize.marginHorizontal),
                    child: Text("Save",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: _fontSize,
                          letterSpacing: _letterSpacing,
                        )))
              ],
            ),
            Container()
          ],
        ),
        onPressed: () => printCallback());
  }
}
