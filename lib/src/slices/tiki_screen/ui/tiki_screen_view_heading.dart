/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../tiki_screen_service.dart';

class TikiScreenViewTitle extends StatelessWidget {
  final String _text;

  TikiScreenViewTitle(this._text);

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<TikiScreenService>(context, listen: false);
    return Text(_text,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontFamily: 'Koara',
            fontSize: service.presenter.fontSizeHeading.sp,
            fontWeight: FontWeight.bold));
  }
}
