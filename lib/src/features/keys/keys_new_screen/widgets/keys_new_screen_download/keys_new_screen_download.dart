/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/keys_new_screen_download_bloc.dart';
import 'widgets/keys_new_screen_download_address.dart';
import 'widgets/keys_new_screen_download_qr.dart';
import 'widgets/keys_new_screen_download_subtitle.dart';
import 'widgets/keys_new_screen_download_title.dart';

class KeysNewScreenDownload extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _KeysNewScreenDownload();
}

class _KeysNewScreenDownload extends State<KeysNewScreenDownload> {
  static final double _marginTopTitle = 15 * PlatformRelativeSize.blockVertical;
  static final double _marginTopSubtitle =
      2.5 * PlatformRelativeSize.blockVertical;
  static final double _marginBottomAddress =
      8 * PlatformRelativeSize.blockVertical;
  static final double _marginVerticalQr =
      1 * PlatformRelativeSize.blockVertical;

  GlobalKey repaintKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    KeysNewScreenDownloadBloc bloc =
        BlocProvider.of<KeysNewScreenDownloadBloc>(context);
    bloc.add(KeysNewScreenDownloadRendered(repaintKey, bloc.state.shouldShare));
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
        key: repaintKey,
        child: Stack(children: [_background(), _foreground()]));
  }

  Widget _background() {
    return Stack(
      children: [
        Container(
          color: ConfigColor.serenade,
        ),
        Container(
            alignment: Alignment.topRight, child: HelperImage("keys-blob")),
      ],
    );
  }

  Widget _foreground() {
    return Row(children: [
      Expanded(
          child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: PlatformRelativeSize.marginHorizontal2x),
              child: Column(children: [
                Container(
                    margin: EdgeInsets.only(top: _marginTopTitle),
                    alignment: Alignment.center,
                    child: KeysNewScreenDownloadTitle()),
                Container(
                    margin: EdgeInsets.only(top: _marginTopSubtitle),
                    alignment: Alignment.center,
                    child: KeysNewScreenDownloadSubtitle()),
                Expanded(
                    child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: _marginVerticalQr),
                        alignment: Alignment.center,
                        child: KeysNewScreenQr())),
                Container(
                    margin: EdgeInsets.only(bottom: _marginBottomAddress),
                    alignment: Alignment.center,
                    child: KeysNewScreenDownloadAddress()),
              ])))
    ]);
  }
}
