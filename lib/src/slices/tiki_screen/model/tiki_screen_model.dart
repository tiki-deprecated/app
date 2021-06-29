import 'package:google_sign_in/google_sign_in.dart';

class TikiScreenModel {
  GoogleSignInAccount? googleAccount;
  int count = 0;
  int referCount = 0;
  String code = "";
  late String version = "";
}
