import 'package:flutter/material.dart';

class HomeNavigatorItemModel {
  final String title;
  final Widget unSelectedIcon;
  final Widget selectedIcon;

  HomeNavigatorItemModel({
    required this.title,
    required this.unSelectedIcon,
    required this.selectedIcon,
  });
}
