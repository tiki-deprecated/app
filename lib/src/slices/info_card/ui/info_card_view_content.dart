import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/info_card/ui/info_card_view_content_explanation.dart';
import 'package:app/src/slices/info_card/ui/info_card_view_what_they_say.dart';
import 'package:app/src/slices/info_card/ui/info_card_view_you_should_know.dart';
import 'package:flutter/material.dart';

import 'info_card_view_cta.dart';

class InfoCardViewContent extends StatelessWidget {
  final BoxConstraints constraints;
  final AnimationController animation;

  InfoCardViewContent(this.constraints, this.animation);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: ConfigColor.mardiGras,
        child: Column(children: [
          InfoCardViewContentExplanation(),
          InfoCardViewWhatTheySay(),
          InfoCardViewYouShouldKnow(),
          InfoCardViewCta(),
        ]));
  }
}
