/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'ui_dots_state.dart';

class UiDotsCubit extends Cubit<UiDotsState> {
  int size;
  UiDotsCubit(this.size, UiDotsInitial uiDotsInitial) : super(uiDotsInitial);

  void increment() {
    state.pos < size - 1
        ? emit(UiDotsSuccess(state.pos + 1))
        : emit(UiDotsFailure(state.pos));
  }

  void decrement() {
    state.pos > 0
        ? emit(UiDotsSuccess(state.pos - 1))
        : emit(UiDotsFailure(state.pos));
  }
}
