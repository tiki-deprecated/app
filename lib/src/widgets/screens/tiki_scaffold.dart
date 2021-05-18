import 'package:app/src/widgets/screens/tiki_background.dart';
import 'package:app/src/widgets/screens/tiki_foreground.dart';
import 'package:flutter/material.dart';

class TikiScaffold extends StatelessWidget {
  final List<Widget> foregroundChildren;
  final Function onHorizontalDrag;
  final Function onVerticalDrag;
  final TikiBackground background;

  const TikiScaffold(
      {Key key,
      @required this.foregroundChildren,
      this.background,
      this.onHorizontalDrag,
      this.onVerticalDrag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
            child: Stack(children: [background, _foreground(context)]),
            onVerticalDragEnd: (dragEndDetails) => onVerticalDrag != null
                ? onVerticalDrag(context, dragEndDetails)
                : null,
            onHorizontalDragEnd: (dragEndDetails) => onHorizontalDrag != null
                ? onHorizontalDrag(context, dragEndDetails)
                : null));
  }

  Widget _foreground(BuildContext context) {
    return TikiForeground(children: foregroundChildren);
  }
}
