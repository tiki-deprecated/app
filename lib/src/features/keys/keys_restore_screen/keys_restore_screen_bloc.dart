/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:async';

import 'package:app/src/features/repo/repo_local_ss_current/repo_local_ss_current.dart';
import 'package:app/src/features/repo/repo_local_ss_current/repo_local_ss_current_model.dart';
import 'package:app/src/features/repo/repo_local_ss_keys/repo_local_ss_keys.dart';
import 'package:app/src/features/repo/repo_local_ss_keys/repo_local_ss_keys_model.dart';
import 'package:app/src/features/repo/repo_local_ss_user/repo_local_ss_user.dart';
import 'package:app/src/features/repo/repo_local_ss_user/repo_local_ss_user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'keys_restore_screen_event.dart';
part 'keys_restore_screen_state.dart';

class KeysRestoreScreenBloc
    extends Bloc<KeysRestoreScreenEvent, KeysRestoreScreenState> {
  final RepoLocalSsKeys _repoLocalSsKeys;
  final RepoLocalSsUser _repoLocalSsUser;
  final RepoLocalSsCurrent _repoLocalSsCurrent;

  KeysRestoreScreenBloc(
      this._repoLocalSsKeys, this._repoLocalSsUser, this._repoLocalSsCurrent)
      : super(KeysRestoreScreenInitial());

  KeysRestoreScreenBloc.provide(BuildContext context)
      : _repoLocalSsKeys = RepositoryProvider.of<RepoLocalSsKeys>(context),
        _repoLocalSsUser = RepositoryProvider.of<RepoLocalSsUser>(context),
        _repoLocalSsCurrent =
            RepositoryProvider.of<RepoLocalSsCurrent>(context),
        super(KeysRestoreScreenInitial());

  @override
  Stream<KeysRestoreScreenState> mapEventToState(
    KeysRestoreScreenEvent event,
  ) async* {
    if (event is KeysRestoreScreenScanned)
      yield* _mapScannedToState(event);
    else if (event is KeysRestoreScreenIdUpdated)
      yield* _mapIdUpdatedToState(event);
    else if (event is KeysRestoreScreenDataKeyUpdated)
      yield* _mapDataKeyUpdatedToState(event);
    else if (event is KeysRestoreScreenSignKeyUpdated)
      yield* _mapSignKeyUpdatedToState(event);
    else if (event is KeysRestoreScreenSubmitted)
      yield* _mapSubmittedToState(event);
  }

  Stream<KeysRestoreScreenState> _mapScannedToState(
      KeysRestoreScreenScanned scanned) async* {
    ScanResult result = await BarcodeScanner.scan();
    if (result.type == ResultType.Barcode) {
      List<String> raw = result.rawContent.split(".");
      String address = raw[0];
      String dataKeyPrivate = raw[1];
      String signKeyPrivate = raw[2];
      if (_isValid(address, dataKeyPrivate, signKeyPrivate)) {
        await _saveAndLogIn(address, dataKeyPrivate, signKeyPrivate);
        yield KeysRestoreScreenSuccess(
            null, dataKeyPrivate, null, signKeyPrivate, address);
      }
    }
  }

  Stream<KeysRestoreScreenState> _mapIdUpdatedToState(
      KeysRestoreScreenIdUpdated idUpdated) async* {
    yield KeysRestoreScreenInProgress(
        state.dataPublic,
        state.dataPrivate,
        state.signPublic,
        state.signPrivate,
        idUpdated.id,
        _isValid(idUpdated.id, state.dataPrivate, state.signPrivate));
  }

  Stream<KeysRestoreScreenState> _mapDataKeyUpdatedToState(
      KeysRestoreScreenDataKeyUpdated dataKeyUpdated) async* {
    yield KeysRestoreScreenInProgress(
        state.dataPublic,
        dataKeyUpdated.dataKey,
        state.signPublic,
        state.signPrivate,
        state.address,
        _isValid(state.address, dataKeyUpdated.dataKey, state.signPrivate));
  }

  Stream<KeysRestoreScreenState> _mapSignKeyUpdatedToState(
      KeysRestoreScreenSignKeyUpdated signKeyUpdated) async* {
    yield KeysRestoreScreenInProgress(
        state.dataPublic,
        state.dataPrivate,
        state.signPublic,
        signKeyUpdated.signKey,
        state.address,
        _isValid(state.address, state.dataPrivate, signKeyUpdated.signKey));
  }

  Stream<KeysRestoreScreenState> _mapSubmittedToState(
      KeysRestoreScreenSubmitted submitted) async* {
    await _saveAndLogIn(state.address!, state.dataPrivate, state.signPrivate);
    yield KeysRestoreScreenSuccess(
      state.dataPublic,
      state.dataPrivate,
      state.signPublic,
      state.signPrivate,
      state.address,
    );
  }

  /// Verify if credentials are valid
  ///
  /// Checks if any of the keys are null and if they have the correct length.
  bool _isValid(
      String? address, String? dataKeyPrivate, String? signKeyPrivate) {
    var addressValid = address != null && address.length == 64;
    var dataKeyValid = dataKeyPrivate != null && dataKeyPrivate.length == 1624;
    var signKeyValid = signKeyPrivate != null && signKeyPrivate.length == 92;
    return addressValid && dataKeyValid && signKeyValid;
  }

  Future<void> _saveAndLogIn(
      String address, String? dataPrivate, String? signPrivate) async {
    await _repoLocalSsKeys.save(
        address,
        RepoLocalSsKeysModel(
            address: address,
            dataPrivateKey: dataPrivate,
            dataPublicKey: null,
            signPrivateKey: signPrivate,
            signPublicKey: null));
    RepoLocalSsCurrentModel current =
        await _repoLocalSsCurrent.find(RepoLocalSsCurrent.key);
    await _repoLocalSsUser.save(
        current.email!,
        RepoLocalSsUserModel(
            email: current.email, address: state.address, isLoggedIn: true));
  }
}
