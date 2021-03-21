/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/magic_link/magic_link_model.dart';
import 'package:rxdart/rxdart.dart';

class MagicLinkBloc {
  MagicLinkModel magicLinkModel;
  BehaviorSubject<MagicLinkModel> _subjectModel;

  MagicLinkBloc() {
    magicLinkModel = MagicLinkModel();
    _subjectModel = BehaviorSubject.seeded(magicLinkModel);
  }

  Observable<MagicLinkModel> get observableModel => _subjectModel.stream;

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
