import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/gmail_data_screen/gmail_data_screen_service.dart';
import 'package:app/src/slices/gmail_data_screen/model/gmail_data_screen_model.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class InforCardTopHeader extends StatelessWidget {
  final InfoCardTopHeaderModel model;

  const InforCardTopHeader({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<GmailDataScreenService>(context, listen:false);
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Expanded(
          child: Row(children: [
        HelperImage(model.logoImage, width: 25),
        Padding(padding: EdgeInsets.only(right: 8)),
        Text(
          model.title,
          style: TextStyle(
              fontFamily: "NunitoSans",
              fontSize: 1.8.h,
              fontWeight: FontWeight.w800,
              color: ConfigColor.tikiBlue),
        )
      ])),
      GestureDetector(
          onTap: () => service.controller
              .shareCard(context, model.shareMessage, model.socialMediaImg),
          child: Icon(Icons.share, color: ConfigColor.orange, size: 40))
    ]);
  }
}
