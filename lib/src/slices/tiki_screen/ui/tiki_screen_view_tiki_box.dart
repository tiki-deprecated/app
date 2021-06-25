import 'package:app/src/slices/tiki_screen/tiki_screen_service.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_tiki_box_counter.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_tiki_box_refer.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_tiki_box_share.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TikiScreenViewTikiBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<TikiScreenService>(context, listen:false);
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 24),
                child: TikiScreenViewTikiBoxCounter(),
              ),
              Container(
                  margin: EdgeInsets.only(top: 30),
                  child: TikiScreenViewTikiBoxRefer()),
              Container(
                  margin: EdgeInsets.symmetric(
                      vertical: service.presenter.marginVerticalShare),
                  alignment: Alignment.topCenter,
                  child: TikiScreenViewTikiBoxShare()),
            ]));
  }
}
