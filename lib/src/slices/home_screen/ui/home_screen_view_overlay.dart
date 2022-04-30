/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiki_kv/tiki_kv.dart';
import 'package:tiki_style/tiki_style.dart';

import '../../home_screen/home_screen_controller.dart';
import '../home_screen_service.dart';

class HomeScreenViewOverlay extends StatelessWidget {
  const HomeScreenViewOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeScreenController controller =
        Provider.of<HomeScreenService>(context, listen: false).controller;
    return GestureDetector(
        onTap: () async => controller
            .dismissOverlay(Provider.of<TikiKv>(context, listen: false)),
        child: Stack(children: [
          FittedBox(
            fit: BoxFit.cover,
          child: ImgProvider.overlayBg,
          ),
          _content(context)
        ]));
  }

  Widget _content(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
          margin: EdgeInsets.only(top: SizeProvider.instance.height(160)),
          width: MediaQuery.of(context).size.width,
          child: ImgProvider.swipeChoices),
      Container(
          margin: EdgeInsets.only(top: SizeProvider.instance.height(36), left: SizeProvider.instance.width(15), right: SizeProvider.instance.width(15)),
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: 'Unsubscribe from an email ',
                  style: TextStyle(
                      color: ColorProvider.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: TextProvider.familyNunitoSans, package: 'tiki_style',
                      fontSize: SizeProvider.instance.text(12)),
                  children: const [
                    TextSpan(
                        text: 'list by swiping left, or\n',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    TextSpan(
                        text: 'keep their emails coming ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: 'by swiping right.',
                        style: TextStyle(fontWeight: FontWeight.w600))
                  ]))),
      Container(
          margin: EdgeInsets.only(top: SizeProvider.instance.height(16), left: SizeProvider.instance.width(12), right: SizeProvider.instance.width(12)),
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: 'Unsubscribing will remove you from an email list.\n',
                  style: TextStyle(
                      color: ColorProvider.tikiOrange,
                      fontWeight: FontWeight.w600,
                      fontFamily: TextProvider.familyNunitoSans, package: 'tiki_style',
                      fontSize: SizeProvider.instance.width(12)),
                  children: const [
                    TextSpan(
                        text:
                            'You can always re-subscribe by going back to their website.',
                        style: TextStyle(color: ColorProvider.white))
                  ])))
    ]);
  }
}
