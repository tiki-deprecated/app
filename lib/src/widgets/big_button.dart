import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/material.dart';

class BigButton extends StatelessWidget{

  final Function _callback;
  final bool _isActive;
  final String _text;

  static final double _letterSpacing =
      0.05 * PlatformRelativeSize.blockHorizontal;
  static final double _fontSize = 6 * PlatformRelativeSize.blockHorizontal;
  static final double _marginHorizontal =
      10 * PlatformRelativeSize.blockHorizontal;
  static final double _marginVertical =
      2.5 * PlatformRelativeSize.blockVertical;

  const BigButton(this._text,  this._isActive, this._callback);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(10 * PlatformRelativeSize.blockVertical))),
            primary: _isActive ? ConfigColor.mardiGras : ConfigColor.mamba),
        child: Wrap(
          direction: Axis.vertical,
          children: [
            Container(
                margin: EdgeInsets.symmetric(
                    vertical: _marginVertical, horizontal: _marginHorizontal),
                child: Center(
                    child: Text(_text,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: _fontSize,
                          letterSpacing: _letterSpacing,
                        ))))
          ],
        ),
        onPressed: _isActive ? () => _callback(context) : null
    );
  }

}
