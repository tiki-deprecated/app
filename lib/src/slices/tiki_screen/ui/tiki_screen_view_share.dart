/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/widgets/components/tiki_inputs/tiki_big_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The [TikiScreenView] share section.
///
/// It handles the "share your code" action and renders the button.
class TikiScreenViewShare extends StatelessWidget {
  static const String _shareText = "It's your data. Get paid for it.";

  @override
  Widget build(BuildContext context) {
    return TikiBigButton("SHARE", true, _share, trailing: Icon(Icons.share));
  }


  _share(_) {
    // Share.share(_state.link.toString(), subject: _shareText);
  }
}