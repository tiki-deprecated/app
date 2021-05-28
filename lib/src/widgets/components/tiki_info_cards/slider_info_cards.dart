import 'package:app/src/config/config_color.dart';
import 'package:app/src/widgets/components/tiki_info_cards/tiki_info_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliderInfoCards extends StatelessWidget {
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
                        GestureDetector(child:Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text('CLOSE ',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: ConfigColor.mardiGras,
                                  fontFamily: "NunitoSans",
                                  fontWeight: FontWeight.w900)),
                          Icon(Icons.close, size: 25, color: ConfigColor.mardiGras),
                        ]),onTap: () => Navigator.of(context).pop()),
                        Padding(padding: EdgeInsets.only(bottom: 16)),
                        Expanded(
                            child: Center(
                                child: (CarouselSlider(
                                  options: CarouselOptions(
                                      viewportFraction: 0.95,
                                      height: MediaQuery.of(context).size.height),
                                  items: [1, 2, 3, 4, 5].map((i) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Container(
                                            width: MediaQuery.of(context).size.width,
                                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                                            padding: EdgeInsets.only(top: 16),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                              BorderRadius.all(Radius.circular(20)),
                                            ),
                                            child: SliderInfoCard());
                                      },
                                    );
                                  }).toList(),
                                ))))
                      ])));
        }));
  }
}

