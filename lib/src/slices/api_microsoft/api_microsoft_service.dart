import '../api_auth_service/api_auth_service.dart';
import '../api_auth_service/model/api_auth_service_account_model.dart';
import '../data_bkg/data_bkg_service_provider.dart';

class ApiMicrosoftService implements DataBkgServiceProvInterface {
  final ApiAuthServiceAccountModel _account;
  final ApiAuthService _apiAuthService;

  ApiMicrosoftService(ApiAuthServiceAccountModel this._account,
      ApiAuthService this._apiAuthService);

  @override
  ApiAuthServiceAccountModel get account => this._account;

  @override
  String? get displayName => this._account.displayName;

  @override
  isConnected() {
    // TODO: implement isConnected
    throw UnimplementedError();
  }

  @override
  logIn() {
    // TODO: implement logIn
    throw UnimplementedError();
  }

  @override
  logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }
}
