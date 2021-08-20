/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../config/config_color.dart';
import 'intro_screen_model_card.dart';

class IntroScreenModel {
  final List<IntroScreenModelCard> cards = [
    IntroScreenModelCard(
        title: 'Take control of your data',
        subtitle:
            'TIKI is a free app that allows you to see, control and monetize your data.',
        button: 'NEXT',
        backgroundColor: ConfigColor.yellow),
    IntroScreenModelCard(
        title: 'Start earning money',
        subtitle:
            'You can also choose to earn money from your data. This is optional.',
        button: 'NEXT',
        backgroundColor: ConfigColor.lightYellow),
    IntroScreenModelCard(
        title: 'We’re stronger together',
        subtitle:
            'You are now part of the TIKI tribe! I’m TIKI and I am here to help you take back your share.',
        button: 'GET STARTED',
        backgroundColor: ConfigColor.lightOrange),
  ];
  bool shouldMoveToLogin = false;
  int currentCard = 0;
}
