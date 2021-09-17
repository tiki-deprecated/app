// ignore_for_file: unused_import

import '../api_auth_service/api_auth_service.dart';
import '../api_auth_service/model/api_auth_service_account_model.dart';
import '../data_bkg/data_bkg_sv_provider_interface.dart';

class ApiMicrosoftService implements DataBkgServiceProviderInterface {
  @override
  isConnected(ApiAuthServiceAccountModel account) {
    // TODO: implement isConnected
    throw UnimplementedError();
  }

  @override
  logIn(ApiAuthServiceAccountModel account) {
    // TODO: implement logIn
    throw UnimplementedError();
  }

  @override
  logOut(ApiAuthServiceAccountModel account) {
    // TODO: implement logOut
    throw UnimplementedError();
  }
}
