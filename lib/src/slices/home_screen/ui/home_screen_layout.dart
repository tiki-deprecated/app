/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api_oauth/api_oauth_service.dart';
import '../../data_fetch/data_fetch_service.dart';
import '../../data_screen/data_screen_service.dart';
import '../../home_screen/ui/home_screen_view_stack.dart';

class HomeScreenLayout extends StatelessWidget {

  const HomeScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataFetchService dataFetchService =
        Provider.of<DataFetchService>(context, listen: false);
    ApiOAuthService apiAuthService =
        Provider.of<ApiOAuthService>(context, listen: false);
    return WillPopScope(
        onWillPop: () async => !Navigator.of(context).userGestureInProgress,
        child: HomeScreenViewStack(
          dataScreenService: DataScreenService(dataFetchService, apiAuthService),
        )
    );
  }
}
