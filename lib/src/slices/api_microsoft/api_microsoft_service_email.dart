import '../api_app_data/api_app_data_service.dart';
import '../api_auth_service/api_auth_service.dart';
import '../api_auth_service/model/api_auth_service_account_model.dart';
import '../api_auth_service/model/api_auth_sv_email_interface.dart';
import '../api_email_msg/model/api_email_msg_model.dart';
import '../data_bkg/model/data_bkg_model_page.dart';

class ApiMicrosoftServiceEmail implements ApiAuthServiceEmailInterface {
  ApiMicrosoftServiceEmail(
      {required ApiAuthServiceAccountModel account,
      required ApiAuthService apiAuthService,
      required ApiAppDataService apiAppDataService})
      : super();

  @override
  Future<DataBkgModelPage<String>> emailFetchList(
      ApiAuthServiceAccountModel account,
      {String? query,
      int? maxResults,
        String? page,
        int? retries}) {
    // TODO: implement emailFetchList
    throw UnimplementedError();
  }

  @override
  Future<ApiEmailMsgModel?> emailFetchMessage(ApiAuthServiceAccountModel account, String messageId,
      {String format = '', List<String>? headers}) {
    // TODO: implement emailFetchMessage
    throw UnimplementedError();
  }

  @override
  Future<int?> getLastFetch() {
    // TODO: implement getLastFetch
    throw UnimplementedError();
  }

  @override
  Future<String> getPage() {
    // TODO: implement getPage
    throw UnimplementedError();
  }

  @override
  Future<String> getQuery({bool fetchAll = true, bool force = true}) async {
    // TODO: implement getQuery
    throw UnimplementedError();
  }

  @override
  Future sendRawMessage(ApiAuthServiceAccountModel account, String getBase64Email) {
    // TODO: implement sendRawMessage
    throw UnimplementedError();
  }

  @override
  Future<void> afterFetchList() {
    // TODO: implement afterFetchList
    throw UnimplementedError();
  }

  @override
  getInfoCards(ApiAuthServiceAccountModel account) {
    // TODO: implement getInfoCards
    throw UnimplementedError();
  }

  get emailProvider => null;
}
