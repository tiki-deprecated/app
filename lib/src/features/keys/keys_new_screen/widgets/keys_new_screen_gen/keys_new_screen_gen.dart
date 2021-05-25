/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/keys/keys_new_screen/bloc/keys_new_screen_bloc.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import 'widgets/keys_new_screen_gen_restore.dart';
import 'widgets/keys_new_screen_gen_subtitle.dart';
import 'widgets/keys_new_screen_gen_title.dart';

class KeysNewScreenGen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _KeysNewScreenGen();
}

class _KeysNewScreenGen extends State<KeysNewScreenGen> {
  static final double _marginTopTitle = 9 * PlatformRelativeSize.blockVertical;
  static final double _marginTopSubtitle =
      2.5 * PlatformRelativeSize.blockVertical;
  static final double _marginBottomButton =
      5 * PlatformRelativeSize.blockVertical;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<KeysNewScreenBloc>(context).add(KeysNewScreenGenerated());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              margin: EdgeInsets.only(top: _marginTopTitle),
              alignment: Alignment.center,
              child: KeysNewScreenGenTitle()),
          Container(
              margin: EdgeInsets.only(top: _marginTopSubtitle),
              alignment: Alignment.center,
              child: KeysNewScreenGenSubtitle()),
          Flexible(
              child: Lottie.asset(
                  "res/animation/Securing_account_with_blob.json")),
          Container(
              margin: EdgeInsets.only(bottom: _marginBottomButton),
              child: KeysNewScreenGenRestore())
        ],
      ),
    );
  }
}
