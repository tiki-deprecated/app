import 'package:app/src/config/config_color.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TikiBigButton extends StatelessWidget {
  final Function _callback;
  final bool _isActive;
  final String _text;
  final Widget? trailing;
  final Widget? leading;
  final double? textWidth;

  static final double _letterSpacing = 0.05.w;
  static final double _fontSize = 6.w;
  static final double _marginHorizontal = 10.w;
  static final double _marginVertical = 2.25.h;

  const TikiBigButton(this._text, this._isActive, this._callback,
      {this.trailing, this.leading, this.textWidth});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
                vertical: _marginVertical,
                horizontal: textWidth != null ? 0 : _marginHorizontal),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.h))),
            primary: _isActive ? ConfigColor.mardiGras : ConfigColor.mamba),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            leading ?? Container(),
            Wrap(
              direction: Axis.vertical,
              children: [
                Container(
                    padding: EdgeInsets.only(right: trailing != null ? 1.w : 0),
                    child: Text(_text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: _fontSize,
                          letterSpacing: _letterSpacing,
                        )))
              ],
            ),
            trailing ?? Container()
          ],
        ),
        onPressed: _isActive ? () => _callback(context) : null);
  }
}
