/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/keys/keys_new_screen/keys_new_screen_bloc.dart';
import 'package:app/src/widgets/components/tiki_big_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The Continue button in save your keys screen.
///
/// Navigates to Home Screen after saving the keys.
class KeysNewScreenSaveContinue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeysNewScreenBloc, KeysNewScreenState>(
        builder: (BuildContext context, KeysNewScreenState state) {
      bool isActive =
          state is KeysNewScreenInProgress ? state.isBackedUp : false;
      return TikiBigButton("CONTINUE", isActive, _continueAfterSave);
    });
  }

  _continueAfterSave(BuildContext context) {
    BlocProvider.of<KeysNewScreenBloc>(context).add(KeysNewScreenContinue());
  }
}
