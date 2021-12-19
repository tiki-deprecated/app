import '../support_screen/support_screen_service.dart';
import '../user_account_modal/user_account_modal_service.dart';
import '../user_referral/user_referral_service.dart';
import 'package:flutter/cupertino.dart';

import 'bottom_sheet_modal_controller.dart';
import 'bottom_sheet_modal_presenter.dart';
import 'model/bottom_sheet_modal_model.dart';
import 'model/bottom_sheet_modal_page.dart';

class BottomSheetModalService extends ChangeNotifier{
  late final BottomSheetModalController controller;
  late final BottomSheetModalPresenter presenter;
  late final BottomSheetModalModel model;

  final UserReferralService referralService;

  BottomSheetModalService(this.referralService){
    this.controller = BottomSheetModalController();
    this.presenter = BottomSheetModalPresenter(this);
    this.model = BottomSheetModalModel();
    setPages();
  }

  void goToSupport() {
    this.model.activePage = BottomSheetModalPage.support;
    notifyListeners();
  }

  void setPages() {
    this.model.pages = [
      UserAccountModalService(referralService).presenter.render(),
      if(true) //this.model.activePage == BottomSheetModalPage.support)
        SupportScreenService().presenter.render()
    ];
  }
}