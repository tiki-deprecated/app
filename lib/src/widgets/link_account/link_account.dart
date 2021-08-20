/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'link_account_view_add.dart';
import 'link_account_view_linked.dart';

class LinkAccount extends StatelessWidget {
  final String type;
  final String? username;
  final String unlinkedIcon;
  final String linkedIcon;
  final Function()? onLink;
  final Function()? onUnlink;
  final Function()? onSee;

  LinkAccount(
      {this.username,
      required this.type,
      required this.unlinkedIcon,
      required this.linkedIcon,
      this.onLink,
      this.onUnlink,
      this.onSee});

  @override
  Widget build(BuildContext context) {
    return username == null
        ? LinkAccountViewAdd(
            text: "Sign in with " + type,
            icon: unlinkedIcon,
            onLink: onLink,
          )
        : LinkAccountViewLinked(
            icon: linkedIcon,
            type: type,
            username: username!,
            onUnlink: onUnlink,
            onSee: onSee,
          );
  }
}
