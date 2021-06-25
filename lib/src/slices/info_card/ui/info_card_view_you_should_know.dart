import 'package:app/src/slices/info_card/info_card_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoCardViewYouShouldKnow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<InfoCardService>(context);
    List<Map> youShouldKnowData =
        this.cardContentData['cardContentData']['youShouldKnow'];
    List<Widget> youShouldKnow = [];
    for (int i = 0; i < youShouldKnowData.length; i++) {
      if (i > 0)
        youShouldKnow.add(Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(
              color: Colors.white,
            )));
      youShouldKnow.add(Row(children: [
        Padding(
            padding: EdgeInsets.only(right: 20),
            child: HelperImage(youShouldKnowData[i]['image'], width: 30)),
        Expanded(
          child: Text(youShouldKnowData[i]['text'],
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: "NunitoSans",
                  color: Colors.white,
                  fontWeight: FontWeight.w500)),
        )
      ]));
    }
    return Container(
        margin: EdgeInsets.all(25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              child: HelperImage(
            "information",
            width: 35,
          )),
          Container(
            margin: EdgeInsets.only(top: 16),
            child: Text("You should know",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "NunitoSans",
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10), child: Container()),
          ...youShouldKnow
        ]));
  }
}
