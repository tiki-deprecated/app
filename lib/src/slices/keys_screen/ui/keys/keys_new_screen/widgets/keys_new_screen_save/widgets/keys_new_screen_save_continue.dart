/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/widgets/components/tiki_inputs/tiki_big_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The Continue button in save your keys screen.
///
/// Navigates to Home Screen after saving the keys.
class KeysNewScreenSaveContinue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TikiBigButton("CONTINUE", true, _continueAfterSave);
  }

  _continueAfterSave(BuildContext context) {
    // BlocProvider.of<KeysNewScreenBloc>(context, listen:false).add(KeysNewScreenContinue());
  }
}
