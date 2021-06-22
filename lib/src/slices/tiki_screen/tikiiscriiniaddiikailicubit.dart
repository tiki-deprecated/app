import 'package:app/src/features/home/home_screen/widgets/home_screen_add_email/bloc/home_screen_add_email_state.dart';
import 'package:app/src/repositories/google/google_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AddEmailCubit extends Cubit<AddEmailState> {
  AddEmailCubit() : super(InitialState());

  void addAccount() async {
    GoogleSignInAccount? googleAccount = await HelperGoogleAuth().connect();
    if (googleAccount != null) emit(AddedState(googleAccount));
  }

  void removeAccount() async {
    var result = await HelperGoogleAuth().handleSignOut();
    if (result) emit(InitialState());
  }
}
