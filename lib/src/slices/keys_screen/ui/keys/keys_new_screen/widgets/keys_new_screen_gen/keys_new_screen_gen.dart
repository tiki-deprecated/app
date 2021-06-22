/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/keys/keys_new_screen/bloc/keys_new_screen_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import 'widgets/keys_new_screen_gen_restore.dart';
import 'widgets/keys_new_screen_gen_subtitle.dart';
import 'widgets/keys_new_screen_gen_title.dart';

class KeysNewScreenGen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _KeysNewScreenGen();
}

class _KeysNewScreenGen extends State<KeysNewScreenGen> {
  static final double _marginTopTitle = 9.h;
  static final double _marginTopSubtitle = 2.5.h;
  static final double _marginBottomButton = 5.h;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<KeysNewScreenBloc>(context).add(KeysNewScreenGenerated());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.95,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          padding: EdgeInsets.only(top: _marginTopTitle),
                          child: KeysNewScreenGenTitle()),
                      Container(
                          margin: EdgeInsets.only(top: _marginTopSubtitle),
                          child: KeysNewScreenGenSubtitle()),
                    ],
                  )
                ],
              ),
              Container(
                child: ClipRect(
                  child: Align(
                      alignment: Alignment.center,
                      heightFactor: 0.5,
                      child: Lottie.asset(
                          "res/animation/Securing_account_with_blob.json")),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(bottom: _marginBottomButton),
                  child: KeysNewScreenGenRestore()),
            ]));
  }
}
