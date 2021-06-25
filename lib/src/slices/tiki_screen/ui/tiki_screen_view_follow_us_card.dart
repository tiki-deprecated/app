import 'package:app/src/slices/tiki_screen/tiki_screen_service.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_card_follow_us.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TikiScreenViewFollowUsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<TikiScreenService>(context, listen:false);
    return Container(
        margin: EdgeInsets.only(top: service.presenter.marginTopCards),
        alignment: Alignment.topCenter,
        child: TikiFollowUsCard());
  }
}
