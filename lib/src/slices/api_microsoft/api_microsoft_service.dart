import '../api_auth_service/model/api_auth_service_account_model.dart';
import '../api_auth_service/model/api_auth_service_rsp.dart';
import '../api_email_msg/model/api_email_msg_model.dart';
import '../data_bkg/api_email_provider_abstract.dart';

class ApiMicrosoftService implements ApiEmailProviderAbstract {
  @override
  // TODO: implement account
  ApiAuthServiceAccountModel get account => throw UnimplementedError();

  @override
  // TODO: implement displayName
  String? get displayName => throw UnimplementedError();

  @override
  Future<ApiAuthServiceRsp> emailFecthList(
      {String? query, int? maxResults, String? page}) {
    // TODO: implement emailFecthList
    // https://graph.microsoft.com/v1.0/me/messages?$top=10&$skip=10
    throw UnimplementedError();
  }

  @override
  Future<ApiEmailMsgModel?> emailFetchMessage(String messageId,
      {String? format, List<String>? headers}) {
    // TODO: implement emailFetchMessage
    //
    throw UnimplementedError();
  }

  @override
  Future sendRawMessage(String getBase64Email) {
    // TODO: implement sendRawMessage
    // https://graph.microsoft.com/v1.0/me/sendMail
    throw UnimplementedError();
  }
}
