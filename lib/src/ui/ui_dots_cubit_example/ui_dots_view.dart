/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app_stash/src/config/config_color.dart';
import 'package:app_stash/src/platform/platform_relative_size.dart';
import 'package:app_stash/src/ui/ui_dots_cubit_example/ui_dots_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UiDotsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UiDotsCubit, UiDotsState>(
      builder: (context, state) {
        return Row(
            children: List.generate(context.read<UiDotsCubit>().size,
                (i) => _dot(i == state.pos ? true : false)));
      },
    );
  }
}

Widget _dot(bool active) {
  final double _size = 1 * PlatformRelativeSize.blockVertical;

  return Container(
    height: _size,
    width: _size,
    margin: EdgeInsets.symmetric(horizontal: _size * 0.5),
    decoration: BoxDecoration(
        color: active ? ConfigColor.mardiGras : ConfigColor.white,
        borderRadius: BorderRadius.all(Radius.circular(_size * 2))),
  );
}
