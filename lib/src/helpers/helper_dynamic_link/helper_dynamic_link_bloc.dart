/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_dynamic_link/helper_dynamic_link_bloc_model.dart';
import 'package:app/src/helpers/helper_dynamic_link/helper_dynamic_link_bloc_model_blockchain.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import 'helper_dynamic_link_bloc_model_bouncer.dart';

class HelperDynamicLinkBloc {
  HelperDynamicLinkBlocModel model = HelperDynamicLinkBlocModel();

  void initBlockchain(HelperDynamicLinkBlocModelBlockchain blockchainModel) {
    model.blockchain = blockchainModel;
  }

  void initBouncer(HelperDynamicLinkBlocModelBouncer bouncerModel) {
    model.bouncer = bouncerModel;
  }

  Future<Uri> createReferralLink(String address) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: 'https://mytiki.app',
        link: Uri.parse('https://mytiki.com/app/blockchain?ref=' + address),
        dynamicLinkParametersOptions: DynamicLinkParametersOptions(
          shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
        ),
        androidParameters: AndroidParameters(
            packageName: 'com.mytiki.app',
            fallbackUrl: Uri.parse(
                'https://play.google.com/store/apps/details?id=com.mytiki.app')),
        iosParameters: IosParameters(
            //appStoreId: '1560250866',
            bundleId: 'com.mytiki.app',
            fallbackUrl:
                Uri.parse('https://testflight.apple.com/join/pUcjaGK8')),
        socialMetaTagParameters: SocialMetaTagParameters(
            title: 'Welcome to TIKI!',
            description: "It's YOUR data. Take back control of it.",
            imageUrl: Uri.parse(
                'https://mytiki.com/og-img-d9216d73be474034a8208d3c613f72a8.png')));

    final ShortDynamicLink shortLink = await parameters.buildShortLink();
    return shortLink.shortUrl;
  }
}
