import 'package:app/src/slices/home_navigator/model/home_navigator_item_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../home_navigator_service.dart';

class HomeNavigatorViewButton extends StatelessWidget {
  final int index;

  const HomeNavigatorViewButton(this.index);

  @override
  Widget build(BuildContext context) {
    HomeNavigatorService service = Provider.of<HomeNavigatorService>(context);
    bool isSelected = service.model.currentScreenIndex == index;
    Color color = isSelected
        ? service.presenter.selectedColor
        : service.presenter.unSelectedColor;
    HomeNavigatorItemModel item = service.presenter.items[index];
    return Expanded(
        child: GestureDetector(
            onTap: () => service.controller.goTo(index, service),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              isSelected ? item.selectedIcon : item.unSelectedIcon,
              Text(item.title,
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w800,
                      fontSize: 12.sp)),
            ])));
  }
}
