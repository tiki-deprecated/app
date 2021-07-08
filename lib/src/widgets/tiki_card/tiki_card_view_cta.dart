import 'package:flutter/material.dart';

abstract class TikiCardViewCta extends StatelessWidget {
  Widget getCta();

  @override
  Widget build(BuildContext context) {
    return getCta();
  }
}
