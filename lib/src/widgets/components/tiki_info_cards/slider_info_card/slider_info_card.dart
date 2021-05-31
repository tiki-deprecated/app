import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/widgets/components/tiki_info_cards/slider_info_card/widgets/animated_card_container.dart';
import 'package:app/src/widgets/components/tiki_info_cards/slider_info_card/widgets/card-content.dart';
import 'package:app/src/widgets/components/tiki_info_cards/slider_info_card/widgets/cover.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SliderInfoCard extends StatelessWidget {
  final Map coverData;
  final Map cardData;

  const SliderInfoCard(
      {Key? key, required this.coverData, required this.cardData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return AnimatedCardContainer(constraints, coverData, cardData);
            })));
  }
}
