/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/ui/ui_refer/ui_refer_bloc_model.dart';

class UIReferBloc {
  UIReferBlocModel _model = UIReferBlocModel();

  UIReferBloc();

  UIReferBlocModel get model => _model;
}
