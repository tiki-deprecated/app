import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/info_card/info_card_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoCardViewCta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<InfoCardService>(context);
    var model = service.model.cardData.cardCtaData;
    return Container(
        padding: EdgeInsets.all(25),
        color: Color(0xFFD8D8D8),
        child: Column(children: [
          Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              width: double.maxFinite,
              child: Text(
                "What can you do about it?",
                style: TextStyle(
                    color: ConfigColor.tikiBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: "NunitoSans"),
              )),
          InfoCardViewCtaRichText(),
          Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(vertical: 25),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: ConfigColor.orange,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                  ),
                  child: Text(model.buttonText,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  onPressed: () =>
                      service.controller.launchUrl(model.btnActionUrl)))
        ]));
  }
}

class InfoCardViewCtaRichText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
