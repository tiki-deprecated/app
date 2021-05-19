/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/features/keys/keys_new_screen/keys_new_screen_bloc.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class KeysNewScreenQr extends StatelessWidget {
  static final double _fontSize = 4 * PlatformRelativeSize.blockHorizontal;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeysNewScreenBloc, KeysNewScreenState>(
        builder: (BuildContext context, KeysNewScreenState state) {
      return QrImage(
          version: QrVersions.auto,
          data: state.address! +
              "." +
              state.dataPrivate! +
              "." +
              state.signPrivate!,
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
          });
    });
  }
}
