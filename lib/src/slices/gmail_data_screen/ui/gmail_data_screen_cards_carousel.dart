import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../gmail_data_screen_service.dart';

class GmailDataScreenCardsCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var presenter = Provider.of<GmailDataScreenService>(context).presenter;
    return Expanded(
        child: Center(
            child: (CarouselSlider(
      options: CarouselOptions(
          viewportFraction: 0.95, height: MediaQuery.of(context).size.height),
      items: presenter.cards.map((card) {
        return Builder(
          builder: (BuildContext context) {
            return card;
          },
        );
      }).toList(),
    ))));
  }
}
