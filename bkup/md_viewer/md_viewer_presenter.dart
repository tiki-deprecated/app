/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/md_viewer/md_viewer_service.dart';
import 'package:app/src/slices/md_viewer/ui/md_viewer_layout.dart';
import 'package:provider/provider.dart';

class MdViewerPresenter {
  final service;

  MdViewerPresenter(this.service);

  ChangeNotifierProvider<MdViewerService> render() {
    return ChangeNotifierProvider.value(
        value: service, child: MdViewerLayout());
  }
}
