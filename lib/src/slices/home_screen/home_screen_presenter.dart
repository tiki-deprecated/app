/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:tiki_style/tiki_style.dart';

import 'home_screen_service.dart';
import 'ui/home_screen_layout.dart';

class HomeScreenPresenter extends Page {
  final HomeScreenService service;
  late final Future<List<SingleChildWidget>> Function(BuildContext)? _provide;

  HomeScreenPresenter(this.service) : super(key: const ValueKey("HomeNav"));

  void inject(Future<List<SingleChildWidget>> Function(BuildContext)? provide) =>
      _provide = provide;

  @override
  Route createRoute(BuildContext context) {

    return MaterialPageRoute(
        settings: this,
        builder: (BuildContext context) => ChangeNotifierProvider.value(
            value: service,
            child: FutureBuilder(
                future: _provide != null
                    ? _provide!(context)
                    : Future.value(List<SingleChildWidget>.empty()),
                builder: (BuildContext context,
                    AsyncSnapshot<List<SingleChildWidget>> snapshot) {
                  if (snapshot.data != null) {
                    return MultiProvider(
                        providers: snapshot.data!, child: const HomeScreenLayout());
                  } else {
                    return Container(
                        color: ColorProvider.greyZero);
                  } //TODO make prettier
                })));
  }
}
