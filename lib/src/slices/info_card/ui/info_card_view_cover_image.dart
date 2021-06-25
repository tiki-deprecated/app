import 'package:app/src/slices/info_card/info_card_service.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InforCardViewCoverImage extends StatelessWidget {
  final Animation<double> controllerValue;

  InforCardViewCoverImage(this.controllerValue);

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<InfoCardService>(context);
    return Align(
        alignment: Alignment(controllerValue.value, -1),
        child: Padding(
            padding: EdgeInsets.only(
                top: service.controller
                    .calculateAnimation(5.8.h, controllerValue.value, 0)),
            child: HelperImage(this.coverData['image'],
                width: service.controller.calculateAnimation(
                    72.91.w, controllerValue.value, 19.7.h))));
  }
}
