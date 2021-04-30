/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:app/src/features/repo/repo_local_ss_keys/repo_local_ss_keys.dart';
import 'package:app/src/features/repo/repo_local_ss_keys/repo_local_ss_keys_model.dart';
import 'package:app/src/utils/helper/helper_crypto.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:share/share.dart';

part 'keys_new_event.dart';
part 'keys_new_state.dart';

class KeysNewBloc extends Bloc<KeysNewEvent, KeysNewState> {
  final RepoLocalSsKeys _repoLocalSsKeys;

  KeysNewBloc(this._repoLocalSsKeys) : super(KeysNewInitial());

  KeysNewBloc.provide(BuildContext context)
      : _repoLocalSsKeys = RepositoryProvider.of<RepoLocalSsKeys>(context),
        super(KeysNewInitial());

  @override
  Stream<KeysNewState> mapEventToState(
    KeysNewEvent event,
  ) async* {
    if (event is KeysNewGenerated)
      yield* _mapGeneratedToState(event);
    else if (event is KeysNewDownloaded)
      yield* _mapDownloadedToState(event);
    else if (event is KeysNewSkipped)
      yield* _mapSkippedToState(event);
    else if (event is KeysNewRendered) yield* _mapRenderedToState(event);
  }

  Stream<KeysNewState> _mapGeneratedToState(KeysNewGenerated generated) async* {
    AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey> dataKey =
        await HelperCrypto.createRSA();
    AsymmetricKeyPair<ECPublicKey, ECPrivateKey> signKey =
        await HelperCrypto.createECDSA();

    String dataPublic = HelperCrypto.encodeRSAPublic(dataKey.publicKey);
    String dataPrivate = HelperCrypto.encodeRSAPrivate(dataKey.privateKey);
    String signPublic = HelperCrypto.encodeECDSAPublic(signKey.publicKey);
    String signPrivate = HelperCrypto.encodeECDSAPrivate(signKey.privateKey);
    String address = HelperCrypto.sha3(signPublic);
    yield KeysNewGenerateInProgress(
        dataPublic, dataPrivate, signPublic, signPrivate, address);
  }

  Stream<KeysNewState> _mapDownloadedToState(
      KeysNewDownloaded downloaded) async* {
    await _repoLocalSsKeys.save(
        state.address,
        RepoLocalSsKeysModel(
            address: state.address,
            dataPrivateKey: state.dataPrivate,
            dataPublicKey: state.dataPublic,
            signPrivateKey: state.signPrivate,
            signPublicKey: state.signPublic));
    yield KeysNewDownloadInProgress(state.dataPublic, state.dataPrivate,
        state.signPublic, state.signPrivate, state.address);
  }

  Stream<KeysNewState> _mapSkippedToState(KeysNewSkipped skipped) async* {
    await _repoLocalSsKeys.save(
        state.address,
        RepoLocalSsKeysModel(
            address: state.address,
            dataPrivateKey: state.dataPrivate,
            dataPublicKey: state.dataPublic,
            signPrivateKey: state.signPrivate,
            signPublicKey: state.signPublic));
    yield KeysNewSuccess(state.dataPublic, state.dataPrivate, state.signPublic,
        state.signPrivate, state.address);
  }

  Stream<KeysNewState> _mapRenderedToState(KeysNewRendered rendered) async* {
    RenderRepaintBoundary renderRepaintBoundary =
        rendered.globalKey.currentContext.findRenderObject();
    ui.Image image = await renderRepaintBoundary.toImage(pixelRatio: 4.0);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    Directory documents = await getApplicationDocumentsDirectory();

    String path = documents.path + '/' + "tiki-do-not-share.png";
    print("saved to: " + path);

    File imgFile = new File(path);
    await imgFile.writeAsBytes(pngBytes);

    await Share.shareFiles([path]);
    yield KeysNewSuccess(state.dataPublic, state.dataPrivate, state.signPublic,
        state.signPrivate, state.address);
  }
}
