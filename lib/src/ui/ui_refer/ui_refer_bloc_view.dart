/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/configs/config_colors.dart';
import 'package:app/src/configs/config_strings.dart';
import 'package:app/src/helpers/helper_security_keys/helper_security_keys_bloc.dart';
import 'package:app/src/helpers/helper_security_keys/helper_security_keys_bloc_provider.dart';
import 'package:app/src/helpers/helper_security_keys/helper_security_keys_model.dart';
import 'package:app/src/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class UIReferBlocView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UIReferBlocView();
}

class _UIReferBlocView extends State<UIReferBlocView> {
  static final double _fSizePlaceholder =
      4 * PlatformRelativeSize.safeBlockHorizontal;
  static final double _hMarginCode =
      1 * PlatformRelativeSize.safeBlockHorizontal;
  static final double _vPaddingReferral =
      1.5 * PlatformRelativeSize.safeBlockVertical;
  static final double _vMargin = 1 * PlatformRelativeSize.safeBlockVertical;

  HelperSecurityKeysBloc _helperSecurityKeysBloc;
  String _refer;

  @override
  Widget build(BuildContext context) {
    _helperSecurityKeysBloc = HelperSecurityKeysBlocProvider.of(context).bloc;
    return Container(
        child: Column(
      children: [_textLine1(), _textLine2(), _codeBlock()],
    ));
  }

  Widget _textLine1() {
    return Text(
      ConfigStrings.homeReferLine1,
      textAlign: TextAlign.center,
      style: GoogleFonts.nunitoSans(
          fontSize: _fSizePlaceholder,
          fontWeight: FontWeight.w600,
          color: ConfigColors.emperor),
    );
  }

  Widget _textLine2() {
    return Text(
      ConfigStrings.homeReferLine2,
      textAlign: TextAlign.center,
      style: GoogleFonts.nunitoSans(
          fontSize: _fSizePlaceholder,
          fontWeight: FontWeight.w800,
          color: ConfigColors.emperor),
    );
  }

  Widget _codeBlock() {
    return Container(
        margin: EdgeInsets.only(top: _vMargin),
        child: OutlinedButton(
            onPressed: () async {
              Clipboard.setData(new ClipboardData(text: _refer));
            },
            style: OutlinedButton.styleFrom(
                side: BorderSide(color: ConfigColors.alto),
                primary: ConfigColors.gray,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(1.5 * _vMargin)))),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Text("YOUR CODE: ",
                  style: GoogleFonts.nunitoSans(
                      fontSize: _fSizePlaceholder,
                      fontWeight: FontWeight.bold,
                      color: ConfigColors.gray)),
              Container(
                  margin: EdgeInsets.only(
                      left: _hMarginCode,
                      right: 3 * _hMarginCode,
                      top: _vPaddingReferral,
                      bottom: _vPaddingReferral),
                  child: FutureBuilder(
                      future: _helperSecurityKeysBloc.load(),
                      builder: (BuildContext context,
                          AsyncSnapshot<HelperSecurityKeysModel> snapshot) {
                        _refer = snapshot.data?.refer == null
                            ? "...."
                            : snapshot.data.refer;
                        return Text(
                            _refer.replaceAll(
                                new RegExp(r'https://mytiki.app/'), ''),
                            style: GoogleFonts.nunitoSans(
                                fontSize: _fSizePlaceholder,
                                fontWeight: FontWeight.bold,
                                color: ConfigColors.stratos));
                      })),
              Image(image: AssetImage("res/images/icon-copy.png"))
            ])));
  }
}
