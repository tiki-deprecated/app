import '../api_auth_service/model/api_auth_service_account_model.dart';
import '../api_auth_service/model/api_auth_service_rsp.dart';
import '../api_email_msg/model/api_email_msg_model.dart';

abstract class ApiEmailProviderService {
  ApiAuthServiceAccountModel get account;

  String? get displayName;

  Future<ApiAuthServiceRsp> emailFecthList(
      {String? query, int? maxResults, String? page});

  Future<ApiEmailMsgModel?> emailFetchMessage(String messageId,
      {String format, List<String>? headers});

  Future<dynamic> sendRawMessage(String getBase64Email);
}
