/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:app/src/widgets/components/tiki_inputs/tiki_big_button.dart';
import 'package:app/src/widgets/components/tiki_text/tiki_subtitle.dart';
import 'package:app/src/widgets/components/tiki_text/tiki_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class KeysNewScreenSaveDialog {
  AlertDialog alert(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: TikiTitle(getTitle(), fontSize: 9),
        content: RepaintBoundary(
            key: getKey() ?? GlobalKey(),
            child: Container(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
              TikiSubtitle(
                getSubtitle(),
                fontWeight: FontWeight.normal,
                fontSize: 4.5 * PlatformRelativeSize.blockHorizontal,
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 16)),
              getContainer(),
              Padding(padding: EdgeInsets.symmetric(vertical: 16)),
              TikiBigButton(
                  getButtonText(), isButtonActive(), getButtonAction())
            ]))));
  }

  String getTitle();

  String getSubtitle();

  Widget getContainer();

  String getButtonText();

  Function getButtonAction();

  bool isButtonActive();

  GlobalKey? getKey() => null;
}
