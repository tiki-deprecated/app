import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AddEmailState extends Equatable {}

class InitialState extends AddEmailState {
  InitialState();

  @override
  List<Object> get props => [];
}

class AddingState extends AddEmailState {
  @override
  List<Object> get props => [];
}

class NotAddedState extends AddEmailState {
  @override
  List<Object> get props => [];
}

class AddedState extends AddEmailState {
  final GoogleSignInAccount? currentUser;

  AddedState(this.currentUser);

  @override
  List<Object?> get props => [currentUser!];
}

class ErrorState extends AddEmailState {
  @override
  List<Object> get props => [];
}
