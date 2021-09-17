import '../../api_email_msg/model/api_email_msg_model.dart';
import '../../data_bkg/model/data_bkg_model_page.dart';
import 'api_auth_service_account_model.dart';

abstract class ApiAuthServiceEmailInterface {
  Future<DataBkgModelPage<String>> emailFetchList(
      ApiAuthServiceAccountModel account,
      {String? query,
      int? maxResults,
      String? page,
      int? retries});

  Future<ApiEmailMsgModel?> emailFetchMessage(
      ApiAuthServiceAccountModel account, String messageId,
      {String format, List<String>? headers});

  Future<dynamic> sendRawMessage(
      ApiAuthServiceAccountModel account, String getBase64Email);

  Future<String> getQuery({bool fetchAll = true, bool force = true});

  Future<int?> getLastFetch();

  Future<String> getPage();

  Future<void> afterFetchList();

  getInfoCards(ApiAuthServiceAccountModel account) {}
}
