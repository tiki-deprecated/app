import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../tiki_screen_service.dart';

class TikiCardText extends StatelessWidget {
  final String text;

  const TikiCardText(this.text);

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<TikiScreenService>(context, listen: false);
    return Text(text,
        style: TextStyle(
            fontSize: service.presenter.fontSizeCardText.sp,
            fontWeight: FontWeight.w600));
  }
}
