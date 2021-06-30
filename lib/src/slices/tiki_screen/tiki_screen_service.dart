import 'package:app/src/slices/api/helper_api_rsp.dart';
import 'package:app/src/slices/google/google_service.dart';
import 'package:app/src/slices/info_carousel/info_carousel_service.dart';
import 'package:app/src/slices/info_carousel_card/model/info_carousel_card_model.dart';
import 'package:app/src/slices/login_screen/model/repo_api_website_users_rsp.dart';
import 'package:app/src/slices/tiki_screen/repository/repo_api_website_users.dart';
import 'package:app/src/slices/tiki_screen/tiki_screen_controller.dart';
import 'package:app/src/slices/tiki_screen/tiki_screen_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:share_plus/share_plus.dart';

import 'model/tiki_screen_model.dart';

class TikiScreenService extends ChangeNotifier {
  static const String _linkUrl = "https://mytiki.com/";
  late TikiScreenModel model;
  late TikiScreenPresenter presenter;
  late TikiScreenController controller;

  GoogleService googleService = GoogleService();

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
    var code = "FIXME"; //TODO swap FIXME with actual user referral code
    HelperApiRsp<RepoApiWebsiteUsersRsp> apiRsp =
        await RepoApiWebsiteUsers.total(code: code);
    if (apiRsp.code == 200) {
      this.model.referCount = apiRsp.data.total;
      notifyListeners();
    } else {
      print(apiRsp);
    }
  }

  void addGoogleAccount() async {
    this.model.googleAccount = await googleService.connect();
    notifyListeners();
  }

  void removeGoogleAccount() async {
    await googleService.handleSignOut();
    this.model.googleAccount = null;
    notifyListeners();
  }

  initializeGoogleRepo() async {
    googleService = GoogleService();
    this.model.googleAccount = await googleService.getConnectedUser();
    notifyListeners();
  }

  void shareLink() {
    var code = "FIXME"; //TODO swap FIXME with actual user referral code
    var body =
        "Your data. Your decisions. Take the take power back from corporations. Together, we triumph. Join us! " +
            _linkUrl +
            code;
    Share.share(body, subject: "Have you seen this???");
  }

  Future<void> copyLink() async {
    var code = "FIXME"; //TODO swap FIXME with actual user referral code
    await Clipboard.setData(new ClipboardData(text: _linkUrl + code));
  }

  Future<void> whatGmailHolds(context) async {
    List<InfoCarouselCardModel> cards = await googleService.getInfoCards();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => InfoCarouselService(cards: cards).getUI()));
  }

  Future<void> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    this.model.version = packageInfo.version;
    notifyListeners();
  }
}
