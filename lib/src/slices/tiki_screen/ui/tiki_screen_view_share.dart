/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/keys/keys_referral/bloc/keys_referral_cubit.dart';
import 'package:app/src/widgets/components/tiki_inputs/tiki_big_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';

/// The [TikiScreenView] share section.
///
/// It handles the "share your code" action and renders the button.
class TikiScreenViewShare extends StatelessWidget {
  static late KeysReferralState _state;
  static const String _shareText = "It's your data. Get paid for it.";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeysReferralCubit, KeysReferralState>(
        builder: (BuildContext context, KeysReferralState state) {
      _state = state;
      return TikiBigButton("SHARE", true, _share, trailing: Icon(Icons.share));
    });
  }

  _share(_) {
    Share.share(_state.link.toString(), subject: _shareText);
  }
}
