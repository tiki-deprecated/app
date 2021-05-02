/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:async';

import 'package:app/src/features/repo/repo_local_ss_keys/repo_local_ss_keys.dart';
import 'package:app/src/features/repo/repo_local_ss_keys/repo_local_ss_keys_model.dart';
import 'package:app/src/utils/helper/helper_crypto.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/ecc/api.dart';

part 'keys_new_screen_event.dart';
part 'keys_new_screen_state.dart';

class KeysNewScreenBloc extends Bloc<KeysNewScreenEvent, KeysNewScreenState> {
  static const fileName = "tiki-do-not-share.png";
  final RepoLocalSsKeys _repoLocalSsKeys;

  KeysNewScreenBloc(this._repoLocalSsKeys) : super(KeysNewScreenInitial());

  KeysNewScreenBloc.provide(BuildContext context)
      : _repoLocalSsKeys = RepositoryProvider.of<RepoLocalSsKeys>(context),
        super(KeysNewScreenInitial());

  @override
  Stream<KeysNewScreenState> mapEventToState(
    KeysNewScreenEvent event,
  ) async* {
    if (event is KeysNewScreenGenerated) yield* _mapGeneratedToState(event);
    if (event is KeysNewScreenBackedUp)
      yield* _mapBackedUpToState(event);
    else if (event is KeysNewScreenSkipped)
      yield* _mapSkippedToState(event);
    else if (event is KeysNewScreenContinue) yield* _mapContinueToState(event);
  }

  Stream<KeysNewScreenState> _mapGeneratedToState(
      KeysNewScreenGenerated generated) async* {
    AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey> dataKey =
        await HelperCrypto.createRSA();
    AsymmetricKeyPair<ECPublicKey, ECPrivateKey> signKey =
        await HelperCrypto.createECDSA();

    String dataPublic = HelperCrypto.encodeRSAPublic(dataKey.publicKey);
    String dataPrivate = HelperCrypto.encodeRSAPrivate(dataKey.privateKey);
    String signPublic = HelperCrypto.encodeECDSAPublic(signKey.publicKey);
    String signPrivate = HelperCrypto.encodeECDSAPrivate(signKey.privateKey);
    String address = HelperCrypto.sha3(signPublic);
    yield KeysNewScreenInProgress(
        dataPublic, dataPrivate, signPublic, signPrivate, address, false);
  }

  Stream<KeysNewScreenState> _mapBackedUpToState(
      KeysNewScreenBackedUp backedUp) async* {
    yield KeysNewScreenInProgress(state.dataPublic, state.dataPrivate,
        state.signPublic, state.signPrivate, state.address, true);
  }

  Stream<KeysNewScreenState> _mapSkippedToState(
      KeysNewScreenSkipped skipped) async* {
    await _repoLocalSsKeys.save(
        state.address,
        RepoLocalSsKeysModel(
            address: state.address,
            dataPrivateKey: state.dataPrivate,
            dataPublicKey: state.dataPublic,
            signPrivateKey: state.signPrivate,
            signPublicKey: state.signPublic));
    yield KeysNewScreenSuccess(state.dataPublic, state.dataPrivate,
        state.signPublic, state.signPrivate, state.address);
  }

  Stream<KeysNewScreenState> _mapContinueToState(
      KeysNewScreenContinue skipped) async* {
    await _repoLocalSsKeys.save(
        state.address,
        RepoLocalSsKeysModel(
            address: state.address,
            dataPrivateKey: state.dataPrivate,
            dataPublicKey: state.dataPublic,
            signPrivateKey: state.signPrivate,
            signPublicKey: state.signPublic));
    yield KeysNewScreenSuccess(state.dataPublic, state.dataPrivate,
        state.signPublic, state.signPrivate, state.address);
  }
}
