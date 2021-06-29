import 'package:app/src/slices/gmail_data_screen/gmail_data_screen_service.dart';
import 'package:app/src/slices/gmail_data_screen/ui/gmail_data_screen_cards_carousel.dart';
import 'package:app/src/slices/gmail_data_screen/ui/gmail_data_screen_view_close.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class GmailDataScreenLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var presenter = Provider.of<GmailDataScreenService>(context).presenter;
    return Scaffold(body: Builder(builder: (BuildContext context) {
      return SafeArea(
          child: Container(
              padding: EdgeInsets.only(
                  bottom: presenter.bottomPadding.h,
                  top: presenter.topPadding.h),
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: presenter.bgColor,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GmailDataScreenViewClose(),
                    Padding(
                        padding: EdgeInsets.only(
                            bottom: presenter.bottomClosePadding.h)),
                    GmailDataScreenCardsCarousel()
                  ])));
    }));
  }
}
