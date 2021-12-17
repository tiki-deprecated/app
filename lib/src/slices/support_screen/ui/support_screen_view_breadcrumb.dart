import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/support_screen/model/support_screen_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../support_screen_service.dart';

class SupportScreenViewBreadcrumb extends StatelessWidget{
  final String catText = "Welcome to our Help Center. Search for an\nanswer or check out our articles below.";
  final String separator = " > ";
  final Color catColor = ConfigColor.tikiBlue;
  final Color defaultColor = ConfigColor.greyFive;

  @override
  Widget build(BuildContext context) {
    SupportScreenService service = Provider.of<SupportScreenService>(context);
    String text = getBreadcrumbText(service);
    return Text(
        text,
        style: TextStyle(
          color: service.model.type == SupportScreenType.category ?
            this.catColor : this.defaultColor
        )
    );
  }

  String getBreadcrumbText(SupportScreenService service) {
    SupportScreenType type = service.model.type;
    String leadText = "All categories";
    switch(type){
      case SupportScreenType.category :
        return catText;
      case SupportScreenType.section:
        return leadText + separator + service.model.name;
      case SupportScreenType.article:
        return leadText + separator + service.model.parentName +
            separator + service.model.name;
    }
  }
}
