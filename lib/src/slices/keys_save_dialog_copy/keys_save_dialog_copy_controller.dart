/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'keys_save_dialog_copy_service.dart';

class KeysSaveDialogCopyController {
  copyField(BuildContext context, String value, bool isEmail) {
    var service =
        Provider.of<KeysSaveDialogCopyService>(context, listen: false);
    Clipboard.setData(new ClipboardData(text: value));
    if (isEmail)
      service.emailCopied();
    else
      service.keyCopied();
  }

  continueAction(BuildContext context) {
    var service =
        Provider.of<KeysSaveDialogCopyService>(context, listen: false);
    service.keysSaveScreenService.keysSaved();
    Navigator.of(context).pop();
  }
}
