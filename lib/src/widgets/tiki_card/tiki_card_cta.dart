import 'package:flutter/material.dart';

abstract class TikiCardCta extends StatelessWidget {
  Widget _getCta();

  @override
  Widget build(BuildContext context) {
    return _getCta();
  }
}
