/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_security_keys/helper_security_keys_model.dart';
import 'package:app/src/repos/repo_ss_security_keys/repo_ss_security_keys_bloc.dart';
import 'package:app/src/repos/repo_ss_security_keys/repo_ss_security_keys_model.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_bloc.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_model.dart';
import 'package:app/src/utilities/utility_error_model.dart';
import 'package:rxdart/rxdart.dart';

import 'helper_security_keys_crypto.dart';

class HelperSecurityKeysBloc {
  static final String _noUserErrorMsg = "No user/uuid";
  static final String _userNotLoggedInMsg = "User not logged in.";

  final RepoSSSecurityKeysBloc repoSSSecurityKeysBloc;
  final RepoSSUserBloc repoSSUserBloc;

  HelperSecurityKeysModel model = HelperSecurityKeysModel();
  BehaviorSubject<HelperSecurityKeysModel> _subjectModel;

  HelperSecurityKeysBloc(this.repoSSUserBloc, this.repoSSSecurityKeysBloc) {
    _subjectModel = BehaviorSubject.seeded(model);
  }

  Observable<HelperSecurityKeysModel> get observable => _subjectModel.stream;

  void dispose() {
    _subjectModel.close();
  }

  Future<void> load() async {
    RepoSSUserModel user = await repoSSUserBloc.find();
    if (user == null || user.uuid == null)
      model.error = StreamErrorModel(_noUserErrorMsg);
    else if (user.loggedIn != null)
      model.error = StreamErrorModel(_userNotLoggedInMsg);
    else {
      RepoSSSecurityKeysModel keys =
          await repoSSSecurityKeysBloc.find(user.uuid);
      model = _from(keys);
    }
    _subjectModel.sink.add(model);
  }

  Future<void> save(HelperSecurityKeysModel keys) async {
    RepoSSUserModel user = await repoSSUserBloc.find();
    if (user == null || user.uuid == null)
      model.error = StreamErrorModel(_noUserErrorMsg);
    else if (user.loggedIn != null)
      model.error = StreamErrorModel(_userNotLoggedInMsg);
    else {
      await repoSSSecurityKeysBloc.save(_to(user.uuid, keys));
    }
    _subjectModel.sink.add(model);
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

  HelperSecurityKeysModel _from(RepoSSSecurityKeysModel ss) {
    HelperSecurityKeysModel keys = HelperSecurityKeysModel();
    keys.address = ss.address;
    keys.signKey.encodedPrivate = ss.signPrivateKey;
    keys.signKey.encodedPublic = ss.signPublicKey;
    keys.dataKey.encodedPublic = ss.signPublicKey;
    keys.dataKey.encodedPrivate = ss.signPrivateKey;
    return keys;
  }

  RepoSSSecurityKeysModel _to(String uuid, HelperSecurityKeysModel helper) {
    return RepoSSSecurityKeysModel(uuid,
        address: helper.address,
        dataPrivateKey: helper.dataKey.encodedPrivate,
        dataPublicKey: helper.dataKey.encodedPublic,
        signPrivateKey: helper.signKey.encodedPrivate,
        signPublicKey: helper.signKey.encodedPrivate);
  }
}
