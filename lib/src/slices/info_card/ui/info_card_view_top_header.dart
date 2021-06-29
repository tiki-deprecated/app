import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/info_card/info_card_service.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class InfoCardViewTopHeader extends StatelessWidget {
  final Animation<double> controllerValue;

  InfoCardViewTopHeader(this.controllerValue);

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<InfoCardService>(context);
    var model = service.model.coverData;
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
            height: service.controller
                .calculateAnimation(7.h, controllerValue.value, 0),
            child: Opacity(
                opacity: 1 - controllerValue.value,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Expanded(
                      child: Row(children: [
                    HelperImage(model.topHeader.logoImage, width: 25),
                    Padding(padding: EdgeInsets.only(right: 8)),
                    Text(
                      model.topHeader.title,
                      style: TextStyle(
                          fontFamily: "NunitoSans",
                          fontSize: 1.8.h,
                          fontWeight: FontWeight.w800,
                          color: ConfigColor.tikiBlue),
                    )
                  ])),
                  GestureDetector(
                      onTap: () => service.controller.shareCard(
                          context,
                          model.topHeader.shareMessage,
                          model.topHeader.socialMediaImg),
                      child: Icon(Icons.share,
                          color: ConfigColor.orange, size: 40))
                ]))));
  }
}
