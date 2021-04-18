/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/configs/config_colors.dart';
import 'package:app/src/configs/config_sizes.dart';
import 'package:app/src/configs/config_strings.dart';
import 'package:app/src/helpers/helper_logout/helper_logout_bloc.dart';
import 'package:app/src/helpers/helper_logout/helper_logout_bloc_provider.dart';
import 'package:app/src/helpers/helper_security_keys/helper_security_keys_bloc.dart';
import 'package:app/src/helpers/helper_security_keys/helper_security_keys_bloc_provider.dart';
import 'package:app/src/helpers/helper_security_keys/helper_security_keys_model.dart';
import 'package:app/src/platform/platform_page_route.dart';
import 'package:app/src/platform/platform_relative_size.dart';
import 'package:app/src/platform/platform_scaffold.dart';
import 'package:app/src/repos/repo_amplitude/repo_amplitude_bloc.dart';
import 'package:app/src/repos/repo_amplitude/repo_amplitude_bloc_provider.dart';
import 'package:app/src/repos/repo_amplitude/repo_amplitude_const.dart'
    as AmpConst;
import 'package:app/src/screens/screen_home.dart';
import 'package:app/src/screens/screen_keys_load.dart';
import 'package:app/src/ui/ui_security_backup/ui_security_backup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenKeysSave extends PlatformScaffold {
  static final double _hPadding =
      ConfigSizes.hPadding * PlatformRelativeSize.safeBlockHorizontal;
  static final double _vMarginStart =
      15 * PlatformRelativeSize.safeBlockVertical;
  static final double _vMargin = 2.5 * PlatformRelativeSize.safeBlockVertical;
  static final double _fSizeTitle =
      10 * PlatformRelativeSize.safeBlockHorizontal;
  static final double _fSizeSubtitle =
      5 * PlatformRelativeSize.safeBlockHorizontal;
  static final double _fSizeLoad = 5 * PlatformRelativeSize.safeBlockHorizontal;
  static final double _fSizeSkip = 4 * PlatformRelativeSize.safeBlockHorizontal;
  static final Widget _toLoad = ScreenKeysLoad();
  static final Widget _toHome = ScreenHome();

  final HelperSecurityKeysModel _newModel;
  RepoAmplitudeBloc _repoAmplitudeBloc;

  ScreenKeysSave(this._newModel);

  @override
  Scaffold androidScaffold(BuildContext context) {
    return Scaffold(body: _stack(context));
  }

  @override
  CupertinoPageScaffold iosScaffold(BuildContext context) {
    return CupertinoPageScaffold(child: _stack(context));
  }

  Widget _stack(BuildContext context) {
    _repoAmplitudeBloc = RepoAmplitudeBlocProvider.of(context).bloc;
    return Stack(
      children: [
        _background(),
        LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
              child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: _foreground(context)));
        })
      ],
    );
  }

  Widget _background() {
    return Stack(
      children: [
        Container(
          color: ConfigColors.serenade,
        ),
        Container(
            child: Align(
                alignment: Alignment.topRight,
                child: Image(image: AssetImage('res/images/keys-blob.png')))),
      ],
    );
  }

  Widget _foreground(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: _hPadding),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          _title(),
          _subtitle(),
          Container(
              margin: EdgeInsets.only(top: _vMargin),
              child: UISecurityBackup(_onBackupComplete, provided: _newModel)),
          _skipButton(context),
          _restoreButton(context, _toLoad)
        ]));
  }

  Widget _title() {
    return Container(
        margin: EdgeInsets.only(top: _vMarginStart),
        child: Align(
            alignment: Alignment.center,
            child: Text(ConfigStrings.keysTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Koara',
                    fontSize: _fSizeTitle,
                    fontWeight: FontWeight.bold,
                    color: ConfigColors.mardiGras))));
  }

  Widget _subtitle() {
    return Container(
        margin: EdgeInsets.only(top: _vMargin),
        child: Align(
            alignment: Alignment.center,
            child: Text(ConfigStrings.keysSubtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunitoSans(
                    fontSize: _fSizeSubtitle,
                    fontWeight: FontWeight.w600,
                    color: ConfigColors.emperor))));
  }

  Widget _restoreButton(BuildContext context, Widget to) {
    return Container(
        margin: EdgeInsets.only(top: _vMargin, bottom: 3 * _vMargin),
        child: Align(
            alignment: Alignment.center,
            child: TextButton(
                onPressed: () {
                  Navigator.push(context, platformPageRoute(to));
                },
                child: Text(ConfigStrings.keysRestore,
                    style: GoogleFonts.nunitoSans(
                        color: ConfigColors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: _fSizeLoad)))));
  }

  Widget _skipButton(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: _vMargin),
        child: Align(
            alignment: Alignment.topCenter,
            child: TextButton(
                onPressed: () async {
                  _repoAmplitudeBloc.event(AmpConst.createAccountE,
                      properties: {
                        AmpConst.createAccountPBackup:
                            AmpConst.createAccountVDownload
                      });
                  await _onBackupComplete(context);
                },
                child: Text(ConfigStrings.keysSkip,
                    style: GoogleFonts.nunitoSans(
                        color: ConfigColors.boulder,
                        fontWeight: FontWeight.bold,
                        fontSize: _fSizeSkip)))));
  }

  Future<void> _onBackupComplete(BuildContext context) async {
    HelperSecurityKeysBloc securityKeysBloc =
        HelperSecurityKeysBlocProvider.of(context).bloc;
    HelperLogoutBloc helperLogoutBloc =
        HelperLogoutBlocProvider.of(context).bloc;

    await securityKeysBloc.save(_newModel).then(
        (HelperSecurityKeysModel saved) async => await securityKeysBloc
                .register()
                .then((HelperSecurityKeysModel registered) {
              _repoAmplitudeBloc.updateUser({
                AmpConst.userPCreated: DateTime.now().toUtc().toIso8601String()
              });
              Navigator.pushAndRemoveUntil(
                  context, platformPageRoute(_toHome), (_) => false);
            }, onError: (error, stackTrace) async {
              await helperLogoutBloc
                  .logoutWithException("Failed to register keys");
            }), onError: (error, stackTrace) async {
      await helperLogoutBloc.logoutWithException("Failed to register keys");
    });
  }
}
