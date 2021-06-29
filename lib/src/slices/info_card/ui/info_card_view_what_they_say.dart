import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/info_card/model/info_card_model.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../info_card_service.dart';

class InfoCardViewWhatTheySay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<InfoCardService>(context);
    List<InfoCardContentTheySayModel> theySayData =
        service.model.cardData.cardContentData.theySay;
    List<Widget> theysay = [];
    for (int i = 0; i < theySayData.length; i++) {
      if (i > 0)
        theysay.add(Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(
              color: Colors.white,
            )));
      theysay.add(Row(children: [
        Padding(
            padding: EdgeInsets.only(right: 20),
            child: HelperImage(theySayData[i].image, width: 30)),
        Expanded(
          child: Text(theySayData[i].text,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: "NunitoSans",
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        )
      ]));
    }
    return Container(
        color: ConfigColor.tikiBlack,
        padding: EdgeInsets.all(25),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
              padding: EdgeInsets.only(bottom: 20),
              width: double.maxFinite,
              child: Text("What Google says it needs it for:",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: "NunitoSans",
                      color: Colors.white,
                      fontWeight: FontWeight.w900))),
          ...theysay
        ]));
  }
}
