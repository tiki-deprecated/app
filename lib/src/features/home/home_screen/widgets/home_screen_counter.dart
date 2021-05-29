/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/features/home/home_counter/bloc/home_counter_cubit.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenCounter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenCounter();
}

class _HomeScreenCounter extends State<HomeScreenCounter> {
  static final double _fontSizeCount =
      20 * PlatformRelativeSize.blockHorizontal;
  static final double _fontSizeText = 5 * PlatformRelativeSize.blockHorizontal;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCounterCubit>(context).update();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCounterCubit, HomeCounterState>(
        builder: (BuildContext context, HomeCounterState state) {
      return Column(children: [
        Text(
            (state.count == null || state.count == 0)
                ? "..."
                : state.count.toString().replaceAllMapped(
                    new RegExp(r'(\d{1,3})(?=(\d{3})+$)'), (m) => "${m[1]},"),
            style: TextStyle(
                color: ConfigColor.flirt,
                fontFamily: 'Koara',
                fontWeight: FontWeight.bold,
                fontSize: 80)),
        Text("people already use TIKI",
            style: TextStyle(
                height: 1,
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: ConfigColor.tikiBlue))
      ]);
    });
  }
}
