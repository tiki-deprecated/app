import 'package:app/src/config/config_color.dart';
import 'package:app/src/widgets/components/tiki_info_cards/slider_info_card/slider_info_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliderInfoCards extends StatelessWidget {
  final List<SliderInfoCard> cards;

  const SliderInfoCards(this.cards);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(builder: (BuildContext context) {
      return SafeArea(
          child: Container(
              padding: EdgeInsets.only(bottom: 20, top: 25),
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Color(0XFFE5E5E5),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('CLOSE ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: ConfigColor.mardiGras,
                                      fontFamily: "NunitoSans",
                                      fontWeight: FontWeight.w900)),
                              Icon(Icons.close,
                                  size: 25, color: ConfigColor.mardiGras),
                            ]),
                        onTap: () => Navigator.of(context).pop()),
                    Padding(padding: EdgeInsets.only(bottom: 16)),
                    Expanded(
                        child: Center(
                            child: (CarouselSlider(
                      options: CarouselOptions(
                          viewportFraction: 0.95,
                          height: MediaQuery.of(context).size.height),
                      items: this.cards.map((card) {
                        return Builder(
                          builder: (BuildContext context) {
                            return card;
                          },
                        );
                      }).toList(),
                    ))))
                  ])));
    }));
  }
}
