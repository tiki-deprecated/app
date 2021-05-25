/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:async';

import 'package:app/src/features/keys/keys_referral/bloc/keys_referral_cubit.dart';
import 'package:app/src/features/repo/repo_api_blockchain_address/repo_api_blockchain_address.dart';
import 'package:app/src/features/repo/repo_api_blockchain_address/repo_api_blockchain_address_req.dart';
import 'package:app/src/features/repo/repo_api_blockchain_address/repo_api_blockchain_address_rsp.dart';
import 'package:app/src/features/repo/repo_local_ss_current/repo_local_ss_current.dart';
import 'package:app/src/features/repo/repo_local_ss_current/repo_local_ss_current_model.dart';
import 'package:app/src/features/repo/repo_local_ss_keys/repo_local_ss_keys.dart';
import 'package:app/src/features/repo/repo_local_ss_keys/repo_local_ss_keys_model.dart';
import 'package:app/src/features/repo/repo_local_ss_user/repo_local_ss_user.dart';
import 'package:app/src/features/repo/repo_local_ss_user/repo_local_ss_user_model.dart';
import 'package:app/src/utils/helper/helper_api_rsp.dart';
import 'package:app/src/utils/helper/helper_crypto.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'keys_new_screen_event.dart';
part 'keys_new_screen_state.dart';

class KeysNewScreenBloc extends Bloc<KeysNewScreenEvent, KeysNewScreenState> {
  static const fileName = "tiki-do-not-share.png";
  final RepoLocalSsKeys _repoLocalSsKeys;
  final RepoLocalSsUser _repoLocalSsUser;
  final RepoLocalSsCurrent _repoLocalSsCurrent;
  final KeysReferralCubit _keysReferralCubit;
  final RepoApiBlockchainAddress _repoApiBlockchainAddress;

  KeysNewScreenBloc(
      this._repoLocalSsKeys,
      this._repoLocalSsUser,
      this._repoLocalSsCurrent,
      this._keysReferralCubit,
      this._repoApiBlockchainAddress)
      : super(KeysNewScreenInitial());

  KeysNewScreenBloc.provide(BuildContext context)
      : _repoLocalSsKeys = RepositoryProvider.of<RepoLocalSsKeys>(context),
        _repoLocalSsUser = RepositoryProvider.of<RepoLocalSsUser>(context),
        _repoLocalSsCurrent =
            RepositoryProvider.of<RepoLocalSsCurrent>(context),
        _keysReferralCubit = BlocProvider.of<KeysReferralCubit>(context),
        _repoApiBlockchainAddress =
            RepositoryProvider.of<RepoApiBlockchainAddress>(context),
        super(KeysNewScreenInitial());

  @override
  Stream<KeysNewScreenState> mapEventToState(
    KeysNewScreenEvent event,
  ) async* {
    if (event is KeysNewScreenGenerated) yield* _mapGeneratedToState(event);
    if (event is KeysNewScreenBackedUp)
      yield* _mapBackedUpToState(event);
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

  Stream<KeysNewScreenState> _mapContinueToState(
      KeysNewScreenContinue skipped) async* {
    if (await _saveAndLogIn()) {
      yield KeysNewScreenSuccess(state.dataPublic, state.dataPrivate,
          state.signPublic, state.signPrivate, state.address);
    } else {
      yield KeysNewScreenFailure(state.dataPublic, state.dataPrivate,
          state.signPublic, state.signPrivate, state.address);
    }
  }

  Future<bool> _saveAndLogIn() async {
    HelperApiRsp<RepoApiBlockchainAddressRsp> rsp =
        await _repoApiBlockchainAddress.issue(RepoApiBlockchainAddressReq(
            state.dataPublic, state.signPublic,
            referFrom: _keysReferralCubit.state.referer));
    if (rsp.code == 200 && rsp.data.address == state.address) {
      await _repoLocalSsKeys.save(
          state.address!,
          RepoLocalSsKeysModel(
              address: state.address,
              dataPrivateKey: state.dataPrivate,
              dataPublicKey: state.dataPublic,
              signPrivateKey: state.signPrivate,
              signPublicKey: state.signPublic));

      RepoLocalSsCurrentModel current =
          await _repoLocalSsCurrent.find(RepoLocalSsCurrent.key);
      await _repoLocalSsUser.save(
          current.email!,
          RepoLocalSsUserModel(
              email: current.email, address: state.address, isLoggedIn: true));
      return true;
    } else {
      Sentry.captureMessage("Failed to register keys with blockchain",
          level: SentryLevel.error);
      return false;
    }
  }
}
