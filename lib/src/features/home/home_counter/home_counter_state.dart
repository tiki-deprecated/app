/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

part of 'home_counter_cubit.dart';

abstract class HomeCounterState extends Equatable {
  final int? count;

  const HomeCounterState(this.count);

  @override
  List<Object?> get props => [count];
}

class HomeCounterInitial extends HomeCounterState {
  const HomeCounterInitial(int count) : super(count);
}

class HomeCounterSuccess extends HomeCounterState {
  const HomeCounterSuccess(int? count) : super(count);
}

class HomeCounterFailure extends HomeCounterState {
  const HomeCounterFailure(int? count) : super(count);
}
