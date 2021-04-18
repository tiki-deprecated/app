/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_dynamic_link/helper_dynamic_link_bloc.dart';
import 'package:app/src/helpers/helper_security_keys/helper_security_keys_exception.dart';
import 'package:app/src/helpers/helper_security_keys/helper_security_keys_model.dart';
import 'package:app/src/repos/repo_blockchain_address/repo_blockchain_address_bloc.dart';
import 'package:app/src/repos/repo_blockchain_address/repo_blockchain_address_model_req.dart';
import 'package:app/src/repos/repo_blockchain_address/repo_blockchain_address_model_rsp.dart';
import 'package:app/src/repos/repo_ss_security_keys/repo_ss_security_keys_bloc.dart';
import 'package:app/src/repos/repo_ss_security_keys/repo_ss_security_keys_model.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_bloc.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_model.dart';
import 'package:app/src/utilities/utility_api_rsp.dart';

import 'helper_security_keys_crypto.dart';

class HelperSecurityKeysBloc {
  static const String _noUserErrorMsg = "No user/uuid";
  static const String _userNotLoggedInMsg = "User not logged in.";
  static const String _noKeysErrorMsg = "No keys exist";
  static const String _addressMismatchErrorMsg = "Blockchain address mismatch";
  static const String _failedRegisterErrorMsg =
      "Failed to register with blockchain";

  final RepoSSSecurityKeysBloc _repoSSSecurityKeysBloc;
  final RepoSSUserBloc _repoSSUserBloc;
  final RepoBlockchainAddressBloc _repoBlockchainAddressBloc;
  final HelperDynamicLinkBloc _helperDynamicLinkBloc;

  HelperSecurityKeysBloc(this._repoSSUserBloc, this._repoSSSecurityKeysBloc,
      this._repoBlockchainAddressBloc, this._helperDynamicLinkBloc);

  Future<HelperSecurityKeysModel> load() async {
    RepoSSUserModel user = await _repoSSUserBloc.find();
    if (user == null || user.uuid == null)
      throw HelperSecurityKeysException(_noUserErrorMsg).sentry();
    else if (!user.loggedIn)
      throw HelperSecurityKeysException(_userNotLoggedInMsg).sentry();
    else {
      RepoSSSecurityKeysModel keys =
          await _repoSSSecurityKeysBloc.find(user.uuid);
      return _from(keys);
    }
  }

  Future<HelperSecurityKeysModel> save(HelperSecurityKeysModel keys) async {
    RepoSSUserModel user = await _repoSSUserBloc.find();
    if (user == null || user.uuid == null)
      throw HelperSecurityKeysException(_noUserErrorMsg).sentry();
    else if (!user.loggedIn)
      throw HelperSecurityKeysException(_userNotLoggedInMsg).sentry();
    else {
      RepoSSSecurityKeysModel ssKeys =
          await _repoSSSecurityKeysBloc.save(_to(user.uuid, keys));
      return _from(ssKeys);
    }
  }

  Future<HelperSecurityKeysModel> create() async {
    HelperSecurityKeysModel keys = HelperSecurityKeysModel();
    keys.dataKey.keyPair = await createRSA();
    keys.signKey.keyPair = await createECDSA();
    keys.dataKey.encodedPrivate =
        encodeRSAPrivate(keys.dataKey.keyPair.privateKey);
    keys.dataKey.encodedPublic =
        encodeRSAPublic(keys.dataKey.keyPair.publicKey);
    keys.signKey.encodedPrivate =
        encodeECDSAPrivate(keys.signKey.keyPair.privateKey);
    keys.signKey.encodedPublic =
        encodeECDSAPublic(keys.signKey.keyPair.publicKey);
    keys.address = sha3(keys.signKey.encodedPublic);
    return keys;
  }

  Future<HelperSecurityKeysModel> register() async {
    RepoSSUserModel user = await _repoSSUserBloc.find();
    RepoSSSecurityKeysModel keys = _to(user.uuid, await load());
    if (user == null || user.loggedIn == false || user.uuid == null)
      throw HelperSecurityKeysException(_noUserErrorMsg).sentry();
    if (keys != null &&
        keys.signPublicKey != null &&
        keys.dataPublicKey != null &&
        keys.address != null) {
      UtilityAPIRsp<RepoBlockchainAddressModelRsp> rsp =
          await _repoBlockchainAddressBloc.issue(RepoBlockchainAddressModelReq(
              keys.dataPublicKey, keys.signPublicKey,
              referFrom: _helperDynamicLinkBloc.model?.blockchain?.ref));
      if (rsp.code == 200) {
        RepoBlockchainAddressModelRsp addressModelRsp = rsp.data;
        if (addressModelRsp.address != keys.address)
          throw HelperSecurityKeysException(_addressMismatchErrorMsg).sentry();
        Uri referLink =
            await _helperDynamicLinkBloc.createReferralLink(keys.address);
        keys.registered = true;
        keys.refer = referLink.toString();
        RepoSSSecurityKeysModel ssKeys =
            await _repoSSSecurityKeysBloc.save(keys);
        return _from(ssKeys);
      } else
        throw HelperSecurityKeysException(
                _failedRegisterErrorMsg + " Code:" + rsp.code.toString())
            .sentry();
    } else
      throw HelperSecurityKeysException(_noKeysErrorMsg).sentry();
  }

  HelperSecurityKeysModel _from(RepoSSSecurityKeysModel ss) {
    HelperSecurityKeysModel keys = HelperSecurityKeysModel();
    keys.address = ss.address;
    keys.signKey.encodedPrivate = ss.signPrivateKey;
    keys.signKey.encodedPublic = ss.signPublicKey;
    keys.dataKey.encodedPublic = ss.dataPublicKey;
    keys.dataKey.encodedPrivate = ss.dataPrivateKey;
    keys.refer = ss.refer;
    return keys;
  }

  RepoSSSecurityKeysModel _to(String uuid, HelperSecurityKeysModel helper) {
    return RepoSSSecurityKeysModel(uuid,
        address: helper.address,
        dataPrivateKey: helper.dataKey.encodedPrivate,
        dataPublicKey: helper.dataKey.encodedPublic,
        signPrivateKey: helper.signKey.encodedPrivate,
        signPublicKey: helper.signKey.encodedPublic,
        refer: helper.refer);
  }
}
