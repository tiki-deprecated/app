import 'package:app/src/config/config_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../tiki_screen_service.dart';

class TikiCardTitle extends StatelessWidget {
  final String? title;
  final Color? textColor;

  const TikiCardTitle(this.title, {this.textColor});

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<TikiScreenService>(context, listen: false);
    return Text(title ?? "",
        style: TextStyle(
            color: textColor ?? ConfigColor.mardiGras,
            fontSize: service.presenter.fontSizeCardTitle.sp,
            fontWeight: FontWeight.w800));
  }
}
