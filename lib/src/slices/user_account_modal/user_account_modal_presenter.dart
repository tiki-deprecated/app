/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'ui/user_account_modal_page.dart';
import 'user_account_modal_service.dart';

class UserAccountModalPresenter {
  final UserAccountModalService service;

  UserAccountModalPresenter(this.service);

  UserAccountModalPage render() {
    return UserAccountModalPage(service);
  }

}