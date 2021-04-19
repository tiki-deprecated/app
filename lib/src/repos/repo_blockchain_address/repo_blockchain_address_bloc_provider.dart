/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_auth_proxy/helper_auth_proxy_bloc.dart';
import 'package:app/src/repos/repo_blockchain_address/repo_blockchain_address_bloc.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_bloc.dart';
import 'package:flutter/cupertino.dart';

class RepoBlockchainAddressBlocProvider extends InheritedWidget {
  final RepoBlockchainAddressBloc _bloc;

  RepoBlockchainAddressBlocProvider(
      RepoSSUserBloc repoSSUserBloc, HelperAuthProxyBloc helperAuthProxyBloc,
      {Key key, Widget child})
      : _bloc = RepoBlockchainAddressBloc(repoSSUserBloc, helperAuthProxyBloc),
        super(key: key, child: child);

  RepoBlockchainAddressBloc get bloc => _bloc;

  static RepoBlockchainAddressBlocProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<
        RepoBlockchainAddressBlocProvider>();
  }

  @override
  bool updateShouldNotify(RepoBlockchainAddressBlocProvider oldWidget) {
    return false;
  }
}
