import 'package:app/src/slices/home_navigator/home_navigator_service.dart';
import 'package:app/src/widgets/icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomeNavigatorViewButtonData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<HomeNavigatorService>(context);
    var color = service.presenter.getItemColor(index: 2);
    return Expanded(
        child: GestureDetector(
            onTap: () => service.controller.goTo(2, service),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(TikiIcons.money, size: 56, color: color),
              Text('Money',
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w800,
                      fontSize: 12.sp)),
            ])));
  }
}
