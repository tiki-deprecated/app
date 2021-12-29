/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';

import 'link_account_view_add_google.dart';
import 'link_account_view_add_microsoft.dart';

abstract class LinkAccountViewAdd extends StatelessWidget {
  factory LinkAccountViewAdd(type, {required text, required icon, onLink}) {
    switch (type) {
      case 'Google':
        return LinkAccountViewAddGoogle(text: text, icon: icon, onLink: onLink);
      case 'Microsoft':
        return LinkAccountViewAddMicrosoft(
            text: text, icon: icon, onLink: onLink);
    }
    throw 'Unknown provider $type';
  }
}
