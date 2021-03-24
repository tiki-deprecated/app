/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/ui/ui_magiclink_send/ui_magic_link_model.dart';
import 'package:rxdart/rxdart.dart';

class UIMagicLinkBloc {
  UIMagicLinkModel magicLinkModel;
  BehaviorSubject<UIMagicLinkModel> _subjectModel;

  UIMagicLinkBloc() {
    magicLinkModel = UIMagicLinkModel();
    _subjectModel = BehaviorSubject.seeded(magicLinkModel);
  }

  Observable<UIMagicLinkModel> get observableModel => _subjectModel.stream;

  void checkInput(String input) {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(input))
      magicLinkModel.isReady = true;
    else
      magicLinkModel.isReady = false;
    _subjectModel.sink.add(magicLinkModel);
  }

  void dispose() {
    _subjectModel.close();
  }
}
