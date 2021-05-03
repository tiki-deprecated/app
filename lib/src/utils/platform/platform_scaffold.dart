/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class PlatformScaffold<I extends CupertinoPageScaffold,
    A extends Scaffold> extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS)
      return iosScaffold(context);
    else
      return androidScaffold(context);
  }

  I iosScaffold(BuildContext context);

  A androidScaffold(BuildContext context);
}
