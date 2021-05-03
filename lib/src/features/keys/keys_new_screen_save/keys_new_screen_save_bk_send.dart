/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/keys/keys_new_screen/keys_new_screen_bloc.dart';
import 'package:app/src/features/keys/keys_new_screen_download/keys_new_screen_download_bloc.dart';
import 'package:app/src/utils/helper/helper_permission.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'keys_new_screen_save_bk.dart';

class KeysNewScreenSaveBkSend extends KeysNewScreenSaveBk {
  static const String _title = "Send/Print";
  static const String _text =
      "CAREFUL! Printing your keys out is great, email is not. Please be careful.";

  KeysNewScreenSaveBkSend() : super(_title, _text, "save-send-icon");

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeysNewScreenBloc, KeysNewScreenState>(
        builder: (BuildContext context, KeysNewScreenState state) {
      return horizontalButton(context, state);
    });
  }

  @override
  void onPressed(BuildContext context, KeysNewScreenState state) async {
    if (await HelperPermission.request(Permission.storage)) {
      BlocProvider.of<KeysNewScreenDownloadBloc>(context)
          .add(KeysNewScreenDownloaded(true));
      BlocProvider.of<KeysNewScreenBloc>(context).add(KeysNewScreenBackedUp());
    }
  }
}
