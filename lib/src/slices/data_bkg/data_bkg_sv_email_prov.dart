import '../api_auth_service/model/api_auth_service_account_model.dart';
import '../api_auth_service/model/api_auth_service_rsp.dart';
import '../api_email_msg/model/api_email_msg_model.dart';
import 'data_bkg_service_provider.dart';

abstract class DataBkgSvEmailProvAbstract
    implements DataBkgServiceProvAbstract {
  ApiAuthServiceAccountModel get account;

  String? get displayName;

  Future<ApiAuthServiceRsp> emailFecthList(
      {String? query, int? maxResults, String? page});

  Future<ApiEmailMsgModel?> emailFetchMessage(String messageId,
      {String format, List<String>? headers});

  Future<dynamic> sendRawMessage(String getBase64Email);

  isConnected() {}
}
