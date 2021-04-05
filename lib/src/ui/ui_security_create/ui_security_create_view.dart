/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/configs/config_colors.dart';
import 'package:app/src/configs/config_strings.dart';
import 'package:app/src/helpers/helper_security_keys/helper_security_keys_bloc_provider.dart';
import 'package:app/src/platform/platform_relative_size.dart';
import 'package:flutter/widgets.dart';

class UISecurityCreateView extends StatelessWidget {
  static final double _vMarginImage =
      15 * PlatformRelativeSize.safeBlockVertical;
  static final double _vMargin = 2.5 * PlatformRelativeSize.safeBlockVertical;
  static final double _fSizeTitle =
      10 * PlatformRelativeSize.safeBlockHorizontal;
  static final double _fSizeSubtitle =
      5 * PlatformRelativeSize.safeBlockHorizontal;

  final Function _onComplete;

  UISecurityCreateView(this._onComplete);

  @override
  Widget build(BuildContext context) {
    HelperSecurityKeysBlocProvider.of(context)
        .bloc
        .create()
        .then((keys) => _onComplete(keys));
    return Column(children: [
      _title(),
      _subtitle(),
      Container(
          margin: EdgeInsets.only(top: _vMarginImage),
          child: Image(
            image: AssetImage('res/images/keys-create-pineapple.png'),
          ))
    ]);
  }

  Widget _title() {
    return Align(
        alignment: Alignment.center,
        child: Text(ConfigStrings.keysCreateTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Koara',
                fontSize: _fSizeTitle,
                fontWeight: FontWeight.bold,
                color: ConfigColors.mardiGras)));
  }

  Widget _subtitle() {
    return Container(
        margin: EdgeInsets.only(top: _vMargin),
        child: Align(
            alignment: Alignment.center,
            child: Text(ConfigStrings.keysCreateSubtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: _fSizeSubtitle,
                    fontWeight: FontWeight.w600,
                    color: ConfigColors.emperor))));
  }
}
