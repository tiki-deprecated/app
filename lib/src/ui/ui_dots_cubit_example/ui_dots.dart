/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app_stash/src/ui/ui_dots_cubit_example/ui_dots_cubit.dart';
import 'package:app_stash/src/ui/ui_dots_cubit_example/ui_dots_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UiDots extends StatelessWidget {
  final int size;
  UiDots(this.size);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UiDotsCubit(size, UiDotsInitial()),
      child: UiDotsView(),
    );
  }
}
