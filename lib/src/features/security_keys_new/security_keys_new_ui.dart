/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/constants/constant_colors.dart';
import 'package:app/src/constants/constant_strings.dart';
import 'package:app/src/features/security_keys_new/security_keys_new_bloc.dart';
import 'package:app/src/features/security_keys_new/security_keys_new_bloc_provider.dart';
import 'package:app/src/features/security_keys_new/security_keys_new_model.dart';
import 'package:app/src/features/security_keys_new/security_keys_new_model_status.dart';
import 'package:app/src/utilities/relative_size.dart';
import 'package:flutter/widgets.dart';

class SecurityKeysNewUI extends StatefulWidget {
  final Function _onComplete;

  SecurityKeysNewUI(this._onComplete);

  @override
  State<StatefulWidget> createState() => _SecurityKeysNewUI(_onComplete);
}

class _SecurityKeysNewUI extends State<SecurityKeysNewUI> {
  static final double _vMarginImage = 15 * RelativeSize.safeBlockVertical;
  static final double _vMargin = 2.5 * RelativeSize.safeBlockVertical;
  static final double _fSizeTitle = 10 * RelativeSize.safeBlockHorizontal;
  static final double _fSizeSubtitle = 5 * RelativeSize.safeBlockHorizontal;

  final Function _onComplete;
  SecurityKeysNewBloc _securityKeysNewBloc;

  _SecurityKeysNewUI(this._onComplete);

  @override
  Widget build(BuildContext context) {
    _securityKeysNewBloc = SecurityKeysNewBlocProvider.of(context).bloc;
    _securityKeysNewBloc.create().then((model) => _onKeysComplete(model));
    return StreamBuilder(
        stream: _securityKeysNewBloc.observableModel,
        initialData: SecurityKeysNewModel(),
        builder: (context, AsyncSnapshot<SecurityKeysNewModel> snapshot) {
          return Column(children: [
            _title(),
            _subtitle(),
            Container(
                margin: EdgeInsets.only(top: _vMarginImage),
                child: Image(
                  image: AssetImage('res/images/keys-create-pineapple.png'),
                )),
          ]);
        });
  }

  @override
  void dispose() {
    _securityKeysNewBloc.dispose();
    super.dispose();
  }

  Widget _title() {
    return Align(
        alignment: Alignment.center,
        child: Text(ConstantStrings.keysCreateTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Koara',
                fontSize: _fSizeTitle,
                fontWeight: FontWeight.bold,
                color: ConstantColors.mardiGras)));
  }

  Widget _subtitle() {
    return Container(
        margin: EdgeInsets.only(top: _vMargin),
        child: Align(
            alignment: Alignment.center,
            child: Text(ConstantStrings.keysCreateSubtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: _fSizeSubtitle,
                    fontWeight: FontWeight.w600,
                    color: ConstantColors.emperor))));
  }

  //TODO handle case where user clicks load before this finishes.
  void _onKeysComplete(SecurityKeysNewModel model) {
    if (model.status == SecurityKeysNewModelStatus.complete) _onComplete(model);
  }
}
