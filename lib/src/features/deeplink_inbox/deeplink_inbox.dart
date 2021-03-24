/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/deeplink_inbox/deeplink_inbox_bloc_provider.dart';
import 'package:app/src/features/deeplink_inbox/deeplink_inbox_ui.dart';
import 'package:flutter/cupertino.dart';

class DeeplinkInbox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DeeplinkInboxBlocProvider(child: DeeplinkInboxUI());
  }
}
