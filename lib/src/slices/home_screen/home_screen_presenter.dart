/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'home_screen_service.dart';
import 'ui/home_screen_layout.dart';

class HomeScreenPresenter extends Page {
  final HomeScreenService service;
  late final Future<List<SingleChildWidget>> Function()? _provide;

  HomeScreenPresenter(this.service) : super(key: ValueKey("HomeNav"));

  void inject(Future<List<SingleChildWidget>> Function()? provide) =>
      _provide = provide;

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (BuildContext context) => ChangeNotifierProvider.value(
            value: service,
            child: FutureBuilder(
                future: _provide != null
                    ? _provide!()
                    : Future.value(List<SingleChildWidget>.empty()),
                builder: (BuildContext context,
                        AsyncSnapshot<List<SingleChildWidget>> snapshot) =>
                    MultiProvider(
                        providers: snapshot.data ?? [],
                        child: HomeScreenLayout()))));
  }
}
