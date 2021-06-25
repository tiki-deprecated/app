import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_card_community.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../tiki_screen_service.dart';

class TikiScreenViewCommunityCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<TikiScreenService>(context);
    return Container(
        margin: EdgeInsets.only(top: service.presenter.marginTopCards),
        alignment: Alignment.topCenter,
        child: TikiCommunityCard());
  }
}
