/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/utils/dynamic_link_handler.dart';
import 'package:flutter/cupertino.dart';

import 'features/keys/keys_new_screen/keys_new_screen.dart';
import 'utils/platform/platform_relative_size.dart';

class Entry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PlatformRelativeSize().init(context);
    return DynamicLinkHandler(child: /*IntroScreenControl()*/ KeysNewScreen());
  }
}
