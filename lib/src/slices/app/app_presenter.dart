/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:provider/provider.dart';

import 'app_service.dart';
import 'ui/app.dart';

class AppPresenter {

  final AppService appService;

  AppPresenter(this.appService);

  ChangeNotifierProvider<AppService> render(){
    return ChangeNotifierProvider.value(
        value: appService,
        child: App()
    );
  }
}