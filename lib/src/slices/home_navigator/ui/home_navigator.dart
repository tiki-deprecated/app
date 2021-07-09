import 'package:app/src/slices/home_navigator/ui/home_navigator_layout.dart';
import 'package:app/src/slices/home_navigator/ui/home_navigator_layout_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeNavigator extends StatelessWidget {
  final bgColor = Color(0xFFE5E5E5);
  final currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: Container(
            color: bgColor,
            child: HomeNavigatorLayout(),
          ),
        ),
        bottomNavigationBar: HomeNavigatorLayoutBottomBar());
  }
}
