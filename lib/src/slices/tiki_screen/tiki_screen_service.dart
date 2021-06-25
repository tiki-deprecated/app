import 'package:app/src/slices/api/helper_api_rsp.dart';
import 'package:app/src/slices/google/repository/google_repository.dart';
import 'package:app/src/slices/login_screen/model/repo_api_website_users_rsp.dart';
import 'package:app/src/slices/tiki_screen/repository/repo_api_website_users.dart';
import 'package:app/src/slices/tiki_screen/tiki_screen_controller.dart';
import 'package:app/src/slices/tiki_screen/tiki_screen_presenter.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import 'model/tiki_screen_model.dart';

class TikiScreenService extends ChangeNotifier {
  late TikiScreenModel model;
  late TikiScreenPresenter presenter;
  late TikiScreenController controller;

  GoogleRepository googleRepository = GoogleRepository();

  TikiScreenService() {
    model = TikiScreenModel();
    controller = TikiScreenController();
    presenter = TikiScreenPresenter(this);
    initializeGoogleRepo();
    getCount();
    getReferCount();
    getVersion();
  }

  Widget getUI() {
    return this.presenter.render();
  }

  Future<void> getCount() async {
    HelperApiRsp<RepoApiWebsiteUsersRsp> apiRsp =
        await RepoApiWebsiteUsers.total();
    if (apiRsp.code == 200) {
      this.model.count = apiRsp.data.total;
      notifyListeners();
    } else {
      print(apiRsp);
    }
  }

  Future<void> getReferCount() async {
    //TODO this needs to connect to the proper API
    this.model.referCount = 666;
    notifyListeners();
  }

  void addGoogleAccount() async {
    this.model.googleAccount = await googleRepository.connect();
    notifyListeners();
  }

  void removeGoogleAccount() async {
    await googleRepository.handleSignOut();
    this.model.googleAccount = null;
    notifyListeners();
  }

  initializeGoogleRepo() async {
    googleRepository = GoogleRepository();
    this.model.googleAccount = await googleRepository.getConnectedUser();
    notifyListeners();
  }

  void shareLink(context, text) {
    //TODO rollback
    // Share.share(this.model.link.toString(), subject: text);
  }

  void whatGmailHolds(context) {
    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => GmailDataScreenService().getUI()));
  }

  Future<void> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    this.model.version = packageInfo.version;
    notifyListeners();
  }
}
