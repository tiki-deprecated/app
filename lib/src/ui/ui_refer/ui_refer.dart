/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/ui/ui_refer/ui_refer_bloc_provider.dart';
import 'package:app/src/ui/ui_refer/ui_refer_bloc_view.dart';
import 'package:flutter/cupertino.dart';

class UIRefer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UIReferBlocProvider(child: UIReferBlocView());
  }
}
