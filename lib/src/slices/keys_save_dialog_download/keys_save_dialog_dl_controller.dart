/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'keys_save_dialog_dl_service.dart';

class KeysSaveDialogDlController {
  downloadQR(
      BuildContext context, GlobalKey<State<StatefulWidget>> repaintKey) async {
    RenderRepaintBoundary renderRepaintBoundary =
        repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    if (!renderRepaintBoundary.debugNeedsPaint) {
      Provider.of<KeysSaveDialogDlService>(context, listen: false)
          .downloadQR(renderRepaintBoundary);
    }
  }
}
