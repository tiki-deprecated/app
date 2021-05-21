/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/keys/keys_restore_screen/widgets/keys_restore_screen_input.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/keys_restore_screen_bloc.dart';

class KeysRestoreScreenInputData extends KeysRestoreScreenInput {
  static const String _placeholder = "Data Key";

  KeysRestoreScreenInputData() : super(_placeholder);

  @override
  void onChanged(BuildContext context, String s) {
    BlocProvider.of<KeysRestoreScreenBloc>(context)
        .add(KeysRestoreScreenDataKeyUpdated(s));
  }
}
