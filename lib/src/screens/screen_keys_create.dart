/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/constants/constant_colors.dart';
import 'package:app/src/constants/constant_sizes.dart';
import 'package:app/src/constants/constant_strings.dart';
import 'package:app/src/features/security_keys_new/security_keys_new.dart';
import 'package:app/src/features/security_keys_new/security_keys_new_model.dart';
import 'package:app/src/screens/screen_keys_load.dart';
import 'package:app/src/screens/screen_keys_save.dart';
import 'package:app/src/utilities/platform_scaffold.dart';
import 'package:app/src/utilities/relative_size.dart';
import 'package:app/src/utilities/utility_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/cupertino/page_scaffold.dart';
import 'package:flutter/src/material/scaffold.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class ScreenKeysCreate extends PlatformScaffold {
  static final double _hPadding =
      ConstantSizes.hPadding * RelativeSize.safeBlockHorizontal;
  static final double _vMarginStart = 15 * RelativeSize.safeBlockVertical;
  static final double _vMarginLoad = 8 * RelativeSize.safeBlockVertical;
  static final double _fSizeLoad = 5 * RelativeSize.safeBlockHorizontal;
  static final Widget _toLoad = ScreenKeysLoad();

  @override
  Scaffold androidScaffold(BuildContext context) {
    return Scaffold(body: _stack(context));
  }

  @override
  CupertinoPageScaffold iosScaffold(BuildContext context) {
    return CupertinoPageScaffold(child: _stack(context));
  }

  Widget _stack(BuildContext context) {
    return Stack(
      children: [_background(), _foreground(context)],
    );
  }

  Widget _background() {
    return Stack(
      children: [
        Container(
          color: ConstantColors.serenade,
        ),
        Container(
            child: Align(
                alignment: Alignment.topRight,
                child: Image(image: AssetImage('res/images/keys-blob.png')))),
      ],
    );
  }

  Widget _foreground(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: _hPadding),
              child: Column(children: [
                Container(
                  margin: EdgeInsets.only(top: _vMarginStart),
                  child:
                      SecurityKeysNew((model) => _onComplete(context, model)),
                ),
                _restoreButton(context, _toLoad)
              ])))
    ]);
  }

  Widget _restoreButton(BuildContext context, Widget to) {
    return Expanded(
        child: Container(
            margin: EdgeInsets.only(bottom: _vMarginLoad),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                    onPressed: () {
                      Navigator.push(context, platformPageRoute(to));
                    },
                    child: Text(ConstantStrings.keysCreateRestore,
                        style: TextStyle(
                            color: ConstantColors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: _fSizeLoad))))));
  }

  void _onComplete(BuildContext context, SecurityKeysNewModel model) {
    Navigator.pushAndRemoveUntil(
        context,
        platformPageRoute(ScreenKeysSave(model.keys)),
        (Route<dynamic> route) => false);
  }
}
