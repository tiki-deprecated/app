import 'api_auth_service_account_model.dart';

abstract class ApiAuthServiceProviderInterface {
  logIn(ApiAuthServiceAccountModel account);

  logOut(ApiAuthServiceAccountModel account);

  isConnected(ApiAuthServiceAccountModel account);
}
