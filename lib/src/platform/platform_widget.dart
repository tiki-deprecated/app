import 'dart:io';

import 'package:flutter/widgets.dart';

abstract class PlatformWidget<I extends Widget, A extends Widget>
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS)
      return iosWidget(context);
    else
      return androidWidget(context);
  }

  I iosWidget(BuildContext context);

  A androidWidget(BuildContext context);
}
