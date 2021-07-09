import 'package:app/src/widgets/icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../home_navigator_service.dart';

class HomeNavigatorViewButtonMoney extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<HomeNavigatorService>(context);
    var color = service.presenter.getItemColor(index: 0);
    return Expanded(
        child: GestureDetector(
            onTap: () => service.controller.goTo(0, service),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(TikiIcons.eye, size: 56, color: color),
              Text('Data',
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w800,
                      fontSize: 12.sp)),
            ])));
  }
}
