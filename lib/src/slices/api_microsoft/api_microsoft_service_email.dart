import '../api_auth_service/api_auth_service.dart';
import '../api_auth_service/model/api_auth_service_account_model.dart';
import '../api_email_msg/model/api_email_msg_model.dart';
import '../data_bkg/data_bkg_sv_email_prov.dart';
import '../data_bkg/model/data_bkg_model_page.dart';
import 'api_microsoft_service.dart';

class ApiMicrosoftServiceEmail extends ApiMicrosoftService
    implements DataBkgSvEmailProvInterface {
  ApiMicrosoftServiceEmail(
      ApiAuthServiceAccountModel account, ApiAuthService apiAuthService)
      : super(account, apiAuthService);

  @override
  Future<DataBkgModelPage<String>> emailFetchList(
      {String? query, int? maxResults, String? page, int? retries}) {
    // TODO: implement emailFetchList
    throw UnimplementedError();
  }

  @override
  Future<ApiEmailMsgModel?> emailFetchMessage(String messageId,
      {String format = '', List<String>? headers}) {
    // TODO: implement emailFetchMessage
    throw UnimplementedError();
  }

  @override
  Future<String> getLastFetch() {
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
  Future sendRawMessage(String getBase64Email) {
    // TODO: implement sendRawMessage
    throw UnimplementedError();
  }

  @override
  Future<void> afterFetchList() {
    // TODO: implement afterFetchList
    throw UnimplementedError();
  }
}
