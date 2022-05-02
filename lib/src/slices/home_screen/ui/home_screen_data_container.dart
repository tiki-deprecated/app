import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiki_data/tiki_data.dart';
import 'package:tiki_decision/tiki_decision.dart';
import 'package:tiki_style/tiki_style.dart';
import 'package:tiki_user_account/tiki_user_account.dart';

import '../../../widgets/header_bar/header_bar.dart';

class HomeScreenDataContainer extends StatelessWidget {
  const HomeScreenDataContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TikiData data = Provider.of<TikiData>(context);
    return data.widget(headerBar: HeaderBar(
      userAccount: Provider.of<TikiUserAccount>(context, listen: false),
    ));
  }
}
