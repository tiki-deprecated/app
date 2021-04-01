/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/constants/constant_colors.dart';
import 'package:app/src/platform/platform_relative_size.dart';
import 'package:app/src/ui/ui_user_counter/ui_user_counter_model.dart';
import 'package:app/src/ui/ui_user_counter/ui_user_counter_provider.dart';
import 'package:flutter/cupertino.dart';

class UIUserCounterView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UIUserCounterView();
}

class _UIUserCounterView extends State<UIUserCounterView> {
  static final double _fSizeCount =
      24 * PlatformRelativeSize.safeBlockHorizontal;
  static final double _fSizeText = 5 * PlatformRelativeSize.safeBlockHorizontal;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: UIUserCounterProvider.of(context).bloc.observable,
        initialData: UIUserCounterModel(),
        builder: (context, AsyncSnapshot<UIUserCounterModel> snapshot) {
          return Column(children: [
            Text(
                snapshot.data.users.toString().replaceAllMapped(
                    new RegExp(r'(\d{1,3})(?=(\d{3})+$)'), (m) => "${m[1]},"),
                style: TextStyle(
                    color: ConstantColors.flirt,
                    fontFamily: 'Koara',
                    fontWeight: FontWeight.bold,
                    fontSize: _fSizeCount)),
            Text("people joined the TIKI tribe",
                style: TextStyle(
                    fontSize: _fSizeText,
                    fontWeight: FontWeight.w900,
                    color: ConstantColors.stratos))
          ]);
        });
  }
}
