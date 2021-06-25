import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_add_email_button.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_community_card.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_follow_us_card.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_logout.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_news_card.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_next_release_card.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_tiki_box.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_title_gs.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_title_updates.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_version.dart';
import 'package:flutter/material.dart';

class TikiScreenLayoutForeground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
      TikiScreenViewTitleGs(),
      TikiScreenViewAddEmailButton(),
      TikiScreenViewTitleUpdates(),
      TikiScreenViewTikiBox(),
      TikiScreenViewNextReleaseCard(),
      TikiScreenViewNewsCard(),
      TikiScreenViewCommunityCard(),
      TikiScreenViewFollowUsCard(),
      TikiScreenViewLogout(),
      TikiScreenViewVersion(),
    ]));
  }
}
