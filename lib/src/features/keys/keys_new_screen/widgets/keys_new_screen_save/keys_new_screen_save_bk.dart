/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/features/keys/keys_new_screen/bloc/keys_new_screen_bloc.dart';
import 'package:app/src/features/keys/keys_new_screen/widgets/keys_new_screen_save/keys_new_screen_dialog/widgets/copy/keys_new_screen_save_dialog_copy.dart';
import 'package:app/src/features/repo/repo_local_ss_current/repo_local_ss_current.dart';
import 'package:app/src/features/repo/repo_local_ss_current/repo_local_ss_current_model.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'keys_new_screen_dialog/bloc/keys_new_screen_save_dialog_bloc.dart';

class KeysNewScreenSaveBk extends StatelessWidget {
  KeysNewScreenSaveBk();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: RepositoryProvider.of<RepoLocalSsCurrent>(context)
            .find(RepoLocalSsCurrent.key),
        builder: (BuildContext context,
            AsyncSnapshot<RepoLocalSsCurrentModel> currentModel) {
          return BlocBuilder<KeysNewScreenSaveDialogCopyBloc,
                  KeysNewScreenSaveDialogCopyState>(
              builder: (context, state) =>
                  _horizontalButton(context, state, currentModel));
        });
  }

  Widget _horizontalButton(
      BuildContext context,
      KeysNewScreenSaveDialogCopyState state,
      AsyncSnapshot<RepoLocalSsCurrentModel> currentModel) {
    KeysNewScreenBloc bloc = BlocProvider.of<KeysNewScreenBloc>(context);
    KeysNewScreenState nsState = bloc.state;
    return GestureDetector(
        child: Stack(clipBehavior: Clip.none, children: [
          Container(
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ]),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: HelperImage("lock-icon")),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Save securely",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 3 * PlatformRelativeSize.blockVertical,
                          color: ConfigColor.mardiGras)),
                  Text("(recommended)",
                      style: TextStyle(
                          fontSize: 3 * PlatformRelativeSize.blockVertical,
                          color: ConfigColor.jade)),
                ])
              ])),
          state is KeysNewScreenSaveDialogCopied
              ? Positioned(
                  top: -30.0, right: -30.0, child: HelperImage("green-check"))
              : Container(),
        ]),
        onTap: () => _saveKey(context, nsState, currentModel.data!));
  }

  _saveKey(BuildContext context, KeysNewScreenState state,
      RepoLocalSsCurrentModel currentModel) async {
    Function copyCallback = () {
      KeysNewScreenSaveDialogCopyBloc bloc =
          BlocProvider.of<KeysNewScreenSaveDialogCopyBloc>(context);
      bloc.add(KeysNewScreenCopied());
      BlocProvider.of<KeysNewScreenBloc>(context).add(KeysNewScreenBackedUp());
    };
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          String key = state.address! +
              '.' +
              state.dataPrivate! +
              '.' +
              state.signPrivate!;
          return KeysNewScreenSaveDialogCopy(key, currentModel,copyCallback).alert(context);
        });
  }
}
