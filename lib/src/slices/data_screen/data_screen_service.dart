/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:decision_sdk/decision.dart';
import 'package:flutter/material.dart';
import 'package:spam_cards/spam_cards.dart';

import '../api_email_sender/api_email_sender_service.dart';
import '../api_email_sender/model/api_email_sender_model.dart';
import '../api_oauth/api_oauth_interface_provider.dart';
import '../api_oauth/api_oauth_service.dart';
import '../api_oauth/model/api_oauth_model_account.dart';
import '../data_fetch/data_fetch_interface_email.dart';
import '../data_fetch/data_fetch_interface_provider.dart';
import '../data_fetch/data_fetch_service.dart';
import 'data_screen_controller.dart';
import 'data_screen_presenter.dart';
import 'model/data_screen_model.dart';

class DataScreenService extends ChangeNotifier {
  late final DataScreenModel _model;
  late final DataScreenPresenter presenter;
  late final DataScreenController controller;
  final DataFetchService _dataFetchService;
  final ApiOAuthService _apiAuthService;
  final SpamCards _spamCards;
  final DecisionSdk _decisionSdk;

  final ApiEmailSenderService _apiEmailSenderService;

  get account => _model.account;

  DataScreenService(this._dataFetchService, this._apiAuthService,
      this._spamCards, this._decisionSdk, this._apiEmailSenderService) {
    _model = DataScreenModel();
    controller = DataScreenController(this);
    presenter = DataScreenPresenter(this);

    _apiAuthService.getAccount().then((account) {
      _model.account = account;
      if (account != null) fetchInbox(account);
      notifyListeners();
    });
  }

  Future<void> saveAccount(dynamic data, String provider) async {
    ApiOAuthModelAccount account = await _apiAuthService.save(data, provider);
    _decisionSdk.setLinked(true);
    _model.account = account;
    fetchInbox(account);
  }

  Future<void> removeAccount(String email, String provider) async {
    _apiAuthService.remove(email, provider);
    _decisionSdk.setLinked(false);
    _model.account = null;
    notifyListeners();
  }

  fetchInbox(ApiOAuthModelAccount account) {
    _dataFetchService.asyncIndex(account, onFinishProccess: _addSpamCards);
    notifyListeners();
  }

  _addSpamCards(List messages) {
    _spamCards.addCards(
        provider: _model.account!.provider!,
        messages: messages,
        onUnsubscribe: _unsubscribeFromSpam,
        onKeep: _keepReceiving);
  }

  Future<bool> _unsubscribeFromSpam(String senderEmail) async {
    DataFetchInterfaceEmail? interfaceEmail = await _getEmailInterface(account);
    if (interfaceEmail == null) throw 'Invalid email interface';
    ApiEmailSenderModel? sender =
        await _apiEmailSenderService.getByEmail(senderEmail);
    if (sender == null) throw 'Invalid sender';
    String unsubscribeMailTo = sender.unsubscribeMailTo!;
    Uri uri = Uri.parse(unsubscribeMailTo);
    String to = uri.path;
    String list = sender.name ?? sender.email!;
    String subject = uri.queryParameters['subject'] ?? "Unsubscribe from $list";
    String body = '''
Hello,<br /><br />
I'd like to stop receiving emails from this email list.<br /><br />
Thanks,<br /><br />
${account.displayName ?? ''}<br />
<br />
''';
    bool success = false;
    await interfaceEmail.send(
        account: account,
        to: to,
        body: body,
        subject: subject,
        onResult: (res) => success = res);
    return success;
  }

  Future<void> _keepReceiving(String senderEmail) async {
    ApiEmailSenderModel? sender =
        await _apiEmailSenderService.getByEmail(senderEmail);
    if (sender != null) {
      await _apiEmailSenderService.markAsKept(sender);
    }
  }

  Future<DataFetchInterfaceEmail?> _getEmailInterface(
      ApiOAuthModelAccount account) async {
    ApiOAuthInterfaceProvider? apiOAuthProvider =
        _apiAuthService.interfaceProviders[account.provider];
    DataFetchInterfaceProvider? dataFetchProvider =
        apiOAuthProvider as DataFetchInterfaceProvider?;
    return dataFetchProvider?.email;
  }
}
