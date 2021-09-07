import 'package:app/src/slices/api_auth_service/model/api_auth_service_account_model.dart';
import 'package:app/src/slices/api_auth_service/model/api_auth_service_rsp.dart';
import 'package:app/src/slices/api_email_msg/model/api_email_msg_model.dart';
import 'package:app/src/slices/data_bkg/data_bkg_sv_email_prov.dart';

class DataBkgSvEmailProvMicrosoft extends DataBkgSvEmailProvAbstract {
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
    throw UnimplementedError();
  }

  @override
  Future<ApiEmailMsgModel?> emailFetchMessage(String messageId,
      {String format, List<String>? headers}) {
    // TODO: implement emailFetchMessage
    throw UnimplementedError();
  }

  @override
  getAccount() {
    // TODO: implement getAccount
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

  @override
  Future sendRawMessage(String getBase64Email) {
    // TODO: implement sendRawMessage
    throw UnimplementedError();
  }
}
