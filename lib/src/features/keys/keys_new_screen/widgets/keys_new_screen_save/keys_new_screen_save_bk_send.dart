/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/keys/keys_new_screen/bloc/keys_new_screen_bloc.dart';
import 'package:app/src/features/keys/keys_new_screen/widgets/keys_new_screen_download/bloc/keys_new_screen_download_bloc.dart';
import 'package:app/src/utils/helper/helper_permission.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

@deprecated
class KeysNewScreenSaveBkSend {


  Widget build(BuildContext context) {
    return BlocBuilder<KeysNewScreenBloc, KeysNewScreenState>(
        builder: (BuildContext context, KeysNewScreenState state) {
      return Container(); //horizontalButton(context, state);
    });
  }
  
  void onPressed(BuildContext context, KeysNewScreenState state) async {
    if (await HelperPermission.request(Permission.storage)) {
      BlocProvider.of<KeysNewScreenDownloadBloc>(context)
          .add(KeysNewScreenDownloaded(true));
      BlocProvider.of<KeysNewScreenBloc>(context).add(KeysNewScreenBackedUp());
    }
  }
}
