import 'package:flutter/material.dart';

import 'keys_modal_view_new_account_create.dart';
import 'keys_modal_view_new_account_recover.dart';
import 'package:sizer/sizer.dart';

class KeysModalViewNewAccount extends StatelessWidget {
  final String _text = "Hi!";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_text),
        KeysModalViewNewAccountCreate(),
        Padding(padding: EdgeInsets.only(top: 0.5 * 2.h)),
        KeysModalViewNewAccountRecover(),
      ],
    );
  }
}