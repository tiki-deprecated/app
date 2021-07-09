import 'package:app/src/slices/home_navigator/ui/home_navigator_view_button_choices.dart';
import 'package:app/src/slices/home_navigator/ui/home_navigator_view_button_data.dart';
import 'package:app/src/slices/home_navigator/ui/home_navigator_view_button_money.dart';
import 'package:flutter/material.dart';

class HomeNavigatorLayoutBottomBar extends StatelessWidget {
  final bgColor = Color(0xFFE5E5E5);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 94,
        color: bgColor,
        child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HomeNavigatorViewButtonData(),
                    HomeNavigatorViewButtonChoices(),
                    HomeNavigatorViewButtonMoney()
                  ],
                ))));
  }
}
