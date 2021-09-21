import 'api_auth_service_account_model.dart';
import 'api_auth_sv_email_interface.dart';

abstract class ApiAuthServiceProviderInterface {
  ApiAuthServiceEmailInterface? get emailProvider;

  logIn(ApiAuthServiceAccountModel account);

  logOut(ApiAuthServiceAccountModel account);

  isConnected(ApiAuthServiceAccountModel account);
}
