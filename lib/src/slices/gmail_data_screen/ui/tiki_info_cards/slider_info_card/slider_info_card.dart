import 'package:app/src/slices/gmail_data_screen/ui/tiki_info_cards/slider_info_card/widgets/animated_card_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliderInfoCard extends StatelessWidget {
  final Map coverData;
  final Map cardData;

  const SliderInfoCard(
      {Key? key, required this.coverData, required this.cardData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return AnimatedCardContainer(constraints, coverData, cardData);
        }));
  }
}
