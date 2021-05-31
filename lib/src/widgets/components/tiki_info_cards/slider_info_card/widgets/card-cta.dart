import 'package:app/src/config/config_color.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CardCta extends StatelessWidget {
  final Map cardCtaArgs;

  const CardCta({Key? key, required this.cardCtaArgs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          this.cardCtaArgs['richTextExplanation'],
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
                  child: Text(this.cardCtaArgs['buttonText'],
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  onPressed: () => this.cardCtaArgs['btnAction']()))
        ]));
  }
}
