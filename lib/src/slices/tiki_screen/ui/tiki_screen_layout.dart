/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/tiki_screen/ui/tiki_screen_layout_background.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_layout_foreground.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_add_email_button.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_card_community.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_card_follow_us.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_card_news.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_card_release.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_tiki_box_counter.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_logout.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_tiki_box_refer.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_tiki_box_share.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_title.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:app/src/widgets/screens/tiki_background.dart';
import 'package:app/src/widgets/screens/tiki_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class TikiScreenLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      return Scaffold(
          body: Center(
              child: GestureDetector(
                  child: Stack(children: [
                    TikiScreenLayoutBackground(),
                    TikiScreenLayoutForeground()
                  ]))));
    }
  }

