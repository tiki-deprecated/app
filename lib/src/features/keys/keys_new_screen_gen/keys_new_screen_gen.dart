/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/keys/keys_new_screen/keys_new_screen_bloc.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'keys_new_screen_gen_restore.dart';
import 'keys_new_screen_gen_subtitle.dart';
import 'keys_new_screen_gen_title.dart';

class KeysNewScreenGen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _KeysNewScreenGen();
}

class _KeysNewScreenGen extends State<KeysNewScreenGen> {
  static final double _marginTopTitle = 15 * PlatformRelativeSize.blockVertical;
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
    return Row(children: [
      Expanded(
          child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: PlatformRelativeSize.marginHorizontal2x),
              child: Column(children: [
                Container(
                    margin: EdgeInsets.only(top: _marginTopTitle),
                    alignment: Alignment.center,
                    child: KeysNewScreenGenTitle()),
                Container(
                    margin: EdgeInsets.only(top: _marginTopSubtitle),
                    alignment: Alignment.center,
                    child: KeysNewScreenGenSubtitle()),
                Expanded(
                    child: Container(
                        alignment: Alignment.center,
                        child: HelperImage("keys-create-pineapple"))),
                Container(
                    margin: EdgeInsets.only(bottom: _marginBottomButton),
                    child: KeysNewScreenGenRestore())
              ])))
    ]);
  }
}
