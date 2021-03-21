import 'package:app/src/constants/constant_colors.dart';
import 'package:app/src/constants/constant_sizes.dart';
import 'package:app/src/constants/constant_strings.dart';
import 'package:app/src/features/magic_link/magic_link.dart';
import 'package:app/src/utilities/platform_scaffold.dart';
import 'package:app/src/utilities/relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenLogin extends PlatformScaffold {
  static final double _lrPadding =
      ConstantSizes.hPadding * RelativeSize.safeBlockHorizontal;
  static final double _vMarginStart = 25 * RelativeSize.safeBlockVertical;
  static final double _vMarginBlob = 46 * RelativeSize.blockSizeVertical;
  static final double _vMarginPineapple = 4 * RelativeSize.safeBlockVertical;
  static final double _vMargin = 2.5 * RelativeSize.safeBlockVertical;
  static final double _fsizeTitle = 10 * RelativeSize.safeBlockHorizontal;
  static final double _fsizeEmailCta = 5 * RelativeSize.safeBlockHorizontal;

  static final String _titleText = ConstantStrings.loginTitle;
  static final String _emailCtaText = ConstantStrings.loginEmailCta;

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

  Widget _foreground(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Container(
              padding: EdgeInsets.only(left: _lrPadding, right: _lrPadding),
              child: Column(children: [
                _title(),
                _emailCta(),
                Container(
                    margin: EdgeInsets.only(top: _vMargin), child: MagicLink())
              ])))
    ]);
  }

  Widget _background() {
    return Stack(
      children: [
        Container(
          color: ConstantColors.serenade,
        ),
        Container(
            margin: EdgeInsets.only(top: _vMarginBlob),
            child: Image(image: AssetImage('res/images/login-blob.png'))),
        Container(
          margin: EdgeInsets.only(top: _vMarginPineapple),
          child: Align(
              alignment: Alignment.topRight,
              child:
                  Image(image: AssetImage('res/images/pineapple-login.png'))),
        ),
      ],
    );
  }

  Widget _title() {
    return Container(
        margin: EdgeInsets.only(top: _vMarginStart),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(_titleText,
                style: TextStyle(
                    fontFamily: 'Koara',
                    fontSize: _fsizeTitle,
                    fontWeight: FontWeight.bold,
                    color: ConstantColors.mardiGras))));
  }

  Widget _emailCta() {
    return Container(
        margin: EdgeInsets.only(top: _vMargin),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(_emailCtaText,
                style: TextStyle(
                    fontSize: _fsizeEmailCta,
                    fontWeight: FontWeight.w600,
                    color: ConstantColors.emperor))));
  }
}
