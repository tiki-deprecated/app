import 'package:app/src/config/config_color.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

class TikiBigInput extends StatelessWidget {
  static final double _paddingHorizontal = 4.w;
  static final double _paddingVertical = 2.h;
  static final double _fontSize = 5.w;

  final String? placeholder;
  final bool? isError;
  final Function? onChanged;

  const TikiBigInput({Key? key, this.placeholder, this.isError, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: _fontSize),
        cursorColor: ConfigColor.orange,
        autocorrect: false,
        autofocus: true,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: _paddingHorizontal, vertical: _paddingVertical),
            hintText: placeholder ?? '',
            hintStyle: TextStyle(
                color: ConfigColor.gray,
                fontWeight: FontWeight.bold,
                fontSize: _fontSize),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: isError!
                        ? ConfigColor.grenadier
                        : ConfigColor.mardiGras,
                    width: 2,
                    style: BorderStyle.solid)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: isError!
                        ? ConfigColor.grenadier
                        : ConfigColor.mardiGras,
                    width: 2,
                    style: BorderStyle.solid))),
        onChanged: (input) => onChanged!(context, input));
  }
}
