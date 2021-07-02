/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../tiki_screen_service.dart';

class TikiScreenLayoutBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<TikiScreenService>(context);
    return Stack(
        children: [Center(child: Container(color: service.presenter.bgcolor))]);
  }
}
