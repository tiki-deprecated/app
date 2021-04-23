part of 'ui_dots_cubit.dart';

abstract class UiDotsState extends Equatable {
  final int pos;

  const UiDotsState(this.pos);
}

class UiDotsInitial extends UiDotsState {
  UiDotsInitial({int pos = 0}) : super(pos);

  @override
  List<Object> get props => [pos];
}

class UiDotsSuccess extends UiDotsState {
  UiDotsSuccess(int pos) : super(pos);

  @override
  List<Object> get props => [pos];
}

class UiDotsFailure extends UiDotsState {
  UiDotsFailure(int pos) : super(pos);

  @override
  List<Object> get props => [pos];
}
