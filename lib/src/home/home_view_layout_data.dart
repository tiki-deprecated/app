/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiki_data/tiki_data.dart';
import 'package:tiki_user_account/tiki_user_account.dart';

import '../header/header_view_layout.dart';

class HomeViewLayoutData extends StatelessWidget {
  const HomeViewLayoutData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TikiData data = Provider.of<TikiData>(context);
    return data.widget(
        headerBar: HeaderViewLayout(
            userAccount: Provider.of<TikiUserAccount>(context, listen: false)));
  }
}
