/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/keys/keys_new_screen/keys_new_screen_bloc.dart';
import 'package:app/src/features/keys/keys_new_screen_download/keys_new_screen_download_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'keys_new_screen_save_bk.dart';

class KeysNewScreenSaveBkDownload extends KeysNewScreenSaveBk {
  static const String _title = "Download";
  static const String _text =
      "We recommend storing off phone, in case you lose it and not iCloud/Google Drive/Dropbox.";
  KeysNewScreenSaveBkDownload() : super(_title, _text, "save-download-icon");

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeysNewScreenBloc, KeysNewScreenState>(
        builder: (BuildContext context, KeysNewScreenState state) {
      return horizontalButton(context, state);
    });
  }

  @override
  void onPressed(BuildContext context, KeysNewScreenState state) {
    BlocProvider.of<KeysNewScreenDownloadBloc>(context)
        .add(KeysNewScreenDownloaded(false));
    BlocProvider.of<KeysNewScreenBloc>(context).add(KeysNewScreenBackedUp());
  }
}
