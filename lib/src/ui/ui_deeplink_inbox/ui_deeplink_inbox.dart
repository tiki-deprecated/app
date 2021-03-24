/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/ui/ui_deeplink_inbox/ui_deeplink_inbox_bloc_provider.dart';
import 'package:app/src/ui/ui_deeplink_inbox/ui_deeplink_inbox_view.dart';
import 'package:flutter/cupertino.dart';

class UIDeeplinkInbox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UIDeeplinkInboxBlocProvider(child: UIDeeplinkInboxView());
  }
}
