/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/repos/repo_website_users/repo_website_users_bloc_provider.dart';
import 'package:flutter/cupertino.dart';

class RepoWebsiteUsers extends StatelessWidget {
  final Widget _child;
  RepoWebsiteUsers({Widget child}) : this._child = child;

  @override
  Widget build(BuildContext context) {
    return RepoWebsiteUsersBlocProvider(child: _child);
  }
}
