import 'dart:convert';

import 'package:logging/logging.dart';

import '../api_auth_service/api_auth_service.dart';
import '../api_auth_service/model/api_auth_service_account_model.dart';
import '../api_email_msg/model/api_email_msg_model.dart';
import 'api_email_provider_abstract.dart';
import 'model/data_bkg_model_page.dart';

class DataBkgServiceEmail {
  final _log = Logger('ApiEmailClientService');
  final ApiAuthService _apiAuthService;
  final ApiEmailProviderAbstract _emailProviderService;

  DataBkgServiceEmail(this._apiAuthService, this._emailProviderService);

  Future<DataBkgModelPage<ApiEmailMsgModel>?> emailFetch(
      ApiAuthServiceAccountModel account,
      {String? query,
      int? maxResults,
      String? page}) async {
    DataBkgModelPage<ApiEmailMsgModel>? emailsPage =
        await _apiAuthService.proxy(
            () => _emailProviderService.emailFecthList(
                query: query, maxResults: maxResults, page: page),
            _emailProviderService.account);
    _log.finest(
        'Fetched ' + (emailsPage?.data?.length.toString() ?? '') + ' messages');
    return emailsPage;
  }

  Future<ApiEmailMsgModel?> emailFetchMessage(String messageId,
      {String format = "metadata",
      List<String>? headers,
      int retries = 3}) async {
    try {
      return await _emailProviderService.emailFetchMessage(messageId,
          format: format, headers: headers);
    } catch (e) {
      _log.warning(
          "emailFetchMessage failed, retries: " + retries.toString(), e);
      if (retries > 1)
        return emailFetchMessage(messageId,
            format: format, headers: headers, retries: retries - 1);
      rethrow;
    }
  }

  Future<bool> unsubscribe(String unsubscribeMailTo, String list) async {
    Uri uri = Uri.parse(unsubscribeMailTo);
    String to = uri.path;
    String subject = uri.queryParameters['subject'] ?? "Unsubscribe from $list";
    String email = '''
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit
to: $to
from: me
subject: $subject

<!DOCTYPE html PUBLIC “-//W3C//DTD XHTML 1.0 Transitional//EN” “https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd”>
<html xmlns=“https://www.w3.org/1999/xhtml”>
<head>
<title>Test Email Sample</title>
<meta http–equiv=“Content-Type” content=“text/html; charset=UTF-8” />
<meta http–equiv=“X-UA-Compatible” content=“IE=edge” />
<meta name=“viewport” content=“width=device-width, initial-scale=1.0 “ />
</head>
<body class=“em_body” style=“margin:0px; padding:0px;”> 
Hello,<br /><br />
I'd like to stop receiving emails from this email list.<br /><br />
Thanks,<br /><br />
${_emailProviderService.account.displayName ?? ''}<br />
<br />
*Sent via http://www.mytiki.com. Join the data ownership<br />
revolution today.<br />
</body>
</html>
''';
    await _apiAuthService.proxy(
        () => _emailProviderService
            .sendRawMessage(base64UrlEncode(utf8.encode(email))),
        _emailProviderService.account);
    return true;
  }
}
