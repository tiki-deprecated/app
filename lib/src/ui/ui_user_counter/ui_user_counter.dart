/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/repos/repo_website_users/repo_website_users_bloc_provider.dart';
import 'package:app/src/ui/ui_user_counter/ui_user_counter_provider.dart';
import 'package:app/src/ui/ui_user_counter/ui_user_counter_view.dart';
import 'package:flutter/cupertino.dart';

class UIUserCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UIUserCounterProvider(RepoWebsiteUsersBlocProvider.of(context).bloc,
        child: UIUserCounterView());
  }
}
