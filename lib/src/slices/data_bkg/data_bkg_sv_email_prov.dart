import '../api_email_msg/model/api_email_msg_model.dart';
import 'model/data_bkg_model_page.dart';

abstract class DataBkgServiceEmailInterface {
  Future<DataBkgModelPage<String>> emailFetchList(
      {String? query, int? maxResults, String? page, int? retries});

  Future<ApiEmailMsgModel?> emailFetchMessage(String messageId,
      {String format, List<String>? headers});

  Future<dynamic> sendRawMessage(String getBase64Email);

  Future<String> getQuery({bool fetchAll = true, bool force = true});

  Future<int?> getLastFetch();

  Future<String> getPage();

  Future<void> afterFetchList();
}
