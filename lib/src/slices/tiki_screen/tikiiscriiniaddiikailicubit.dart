

// class AddEmailCubit extends Cubit<AddEmailState> {
//   AddEmailCubit() : super(InitialState());
//
//   void addAccount() async {
//     GoogleSignInAccount? googleAccount = await HelperGoogleAuth().connect();
//     if (googleAccount != null) emit(AddedState(googleAccount));
//   }
//
//   void removeAccount() async {
//     var result = await HelperGoogleAuth().handleSignOut();
//     if (result) emit(InitialState());
//   }
// }
