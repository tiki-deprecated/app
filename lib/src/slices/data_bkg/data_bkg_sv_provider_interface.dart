import '../api_auth_service/model/api_auth_service_account_model.dart';

abstract class DataBkgServiceProviderInterface {
  logIn(ApiAuthServiceAccountModel account);

  logOut(ApiAuthServiceAccountModel account);

  isConnected(ApiAuthServiceAccountModel account);
}
