import 'package:app/src/widgets/header_bar/header_bar.dart';
import 'package:flutter/material.dart';

import 'home_navigator_layout_stage.dart';

class HomeNavigatorLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [HeaderBar(), HomeNavigatorLayoutStage()]);
  }
}
