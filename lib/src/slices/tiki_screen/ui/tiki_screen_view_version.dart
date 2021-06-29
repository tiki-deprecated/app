import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/tiki_screen/tiki_screen_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TikiScreenViewVersion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<TikiScreenService>(context);
    return Text(
        "TIKI Inc." +
            (service.model.version != null
                ? " | Release " + service.model.version!
                : ""),
        style: TextStyle(
            fontSize: service.presenter.fontSizeVersion.sp,
            fontWeight: FontWeight.w600,
            color: ConfigColor.boulder));
  }
}
