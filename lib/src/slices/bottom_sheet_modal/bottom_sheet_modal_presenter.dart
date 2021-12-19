import 'package:provider/provider.dart';

import '../../config/config_color.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'bottom_sheet_modal_service.dart';


class BottomSheetModalPresenter{

  final BottomSheetModalService service;

  BottomSheetModalPresenter(this.service);

  Widget render(){
    return ChangeNotifierProvider.value(value: this.service, child: Navigator(
      pages: service.model.pages,
      onPopPage: (route, result) => route.didPop(result),
    ));
  }

  Future<void> showModal(BuildContext context) {
    return showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        backgroundColor: ConfigColor.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(4.5.h))),
        builder: (BuildContext context) => render());
  }
}