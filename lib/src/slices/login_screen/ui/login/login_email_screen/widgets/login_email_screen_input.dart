/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/widgets/components/tiki_inputs/tiki_big_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginEmailScreenInput extends StatelessWidget {
  static const String _placeholder = "Your email";

  @override
  Widget build(BuildContext context) {
    return TikiBigInput(
          placeholder: _placeholder,
          onChanged: () => {});
    }
  }

