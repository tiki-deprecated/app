import 'package:flutter/material.dart';

abstract class TikiCardCta extends StatelessWidget {
  Widget getCta();

  @override
  Widget build(BuildContext context) {
    return getCta();
  }
}
