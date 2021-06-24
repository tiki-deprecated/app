/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/app/model/app_model_current.dart';
import 'package:app/src/slices/app/repository/secure_storage_repository_current.dart';
import 'package:app/src/slices/keys_screen/ui/keys/keys_new_screen/bloc/keys_new_screen_bloc.dart';
import 'package:app/src/slices/keys_screen/ui/keys/keys_new_screen/widgets/keys_new_screen_dialog_copy/keys_new_screen_dialog_copy.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../keys_new_screen_dialog_copy/bloc/keys_new_screen_dialog_copy_bloc.dart';

class KeysNewScreenSaveBk extends StatelessWidget {
  KeysNewScreenSaveBk();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => KeysNewScreenDialogCopyBloc(),
        child: FutureBuilder(
            future:
                RepositoryProvider.of<SecureStorageRepositoryCurrent>(context, listen:false)
                    .find(SecureStorageRepositoryCurrent.key),
            builder: (BuildContext context,
                AsyncSnapshot<AppModelCurrent> currentModel) {
              return BlocConsumer<KeysNewScreenDialogCopyBloc,
                      KeysNewScreenDialogCopyState>(
                  listener: (BuildContext context,
                      KeysNewScreenDialogCopyState state) {
                    if (state is KeysNewScreenDialogCopySuccess && state.isKey)
                      BlocProvider.of<KeysNewScreenBloc>(context, listen:false)
                          .add(KeysNewScreenBackedUp());
                  },
                  builder: (BuildContext context,
                          KeysNewScreenDialogCopyState state) =>
                      _horizontalButton(context, state, currentModel));
            }));
  }

  Widget _horizontalButton(
      BuildContext context,
      KeysNewScreenDialogCopyState state,
      AsyncSnapshot<AppModelCurrent> currentModel) {
    return GestureDetector(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Stack(clipBehavior: Clip.none, children: [
              Container(
                  margin: EdgeInsets.only(bottom: 4.w),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: ConfigColor.alto),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          spreadRadius: 0,
                          blurRadius: 16,
                          offset: Offset(6, 6), // changes position of shadow
                        ),
                      ]),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 0.5.h, right: 4.w),
                            child: HelperImage("lock-icon")),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Save securely",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 3.h,
                                      color: ConfigColor.mardiGras)),
                              Text("(recommended)",
                                  style: TextStyle(
                                      fontSize: 3.h,
                                      fontWeight: FontWeight.bold,
                                      color: ConfigColor.jade)),
                            ])
                      ])),
              state is KeysNewScreenDialogCopySuccess && state.isKey
                  ? Positioned(
                      top: 0.25.h,
                      left: 6.w,
                      child: Container(
                          height: 5.h, child: HelperImage("green-check")))
                  : Container(),
            ])),
        onTap: () => _saveKey(context, currentModel.data!));
  }

  _saveKey(BuildContext context, AppModelCurrent currentModel) async {
    // KeysNewScreenState state =
    //     BlocProvider.of<KeysNewScreenBloc>(context, listen:false).state;
    // KeysNewScreenDialogCopyBloc bloc =
    //     BlocProvider.of<KeysNewScreenDialogCopyBloc>(context, listen:false);
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          String key = "";
          // state.address! +
          //     '.' +
          //     state.dataPrivate! +
          //     '.' +
          //     state.signPrivate!;
          return KeysNewScreenDialogCopy().alert(key, currentModel);
        });
  }
}
