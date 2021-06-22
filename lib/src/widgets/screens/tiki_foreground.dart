import 'package:flutter/material.dart';

class TikiForeground extends StatelessWidget {
  final List<Widget> children;

  const TikiForeground({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: EdgeInsets.symmetric(
        //     horizontal: PlatformRelativeSize.marginHorizontal2x),
        child: SingleChildScrollView(child: Column(children: this.children)));
  }
}
