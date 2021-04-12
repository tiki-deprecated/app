/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_auth_proxy/helper_auth_proxy_bloc_provider.dart';
import 'package:app/src/repos/repo_blockchain_address/repo_blockchain_address_bloc_provider.dart';
import 'package:app/src/repos/repo_ss_user/repo_ss_user_bloc_provider.dart';
import 'package:flutter/cupertino.dart';

class RepoBlockchainAddress extends StatelessWidget {
  final Widget _child;
  RepoBlockchainAddress({Widget child}) : this._child = child;

  @override
  Widget build(BuildContext context) {
    return RepoBlockchainAddressBlocProvider(
        RepoSSUserBlocProvider.of(context).bloc,
        HelperAuthProxyBlocProvider.of(context).bloc,
        child: _child);
  }
}
