/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_dynamic_link/helper_dynamic_link_bloc_model.dart';
import 'package:app/src/helpers/helper_dynamic_link/helper_dynamic_link_bloc_model_blockchain.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import 'helper_dynamic_link_bloc_model_bouncer.dart';

class HelperDynamicLinkBloc {
  HelperDynamicLinkBlocModel model;

  void initBlockchain(HelperDynamicLinkBlocModelBlockchain blockchainModel) {
    model = HelperDynamicLinkBlocModel(blockchain: blockchainModel);
  }

  void initBouncer(HelperDynamicLinkBlocModelBouncer bouncerModel) {
    model = HelperDynamicLinkBlocModel(bouncer: bouncerModel);
  }

  Future<Uri> createReferralLink(String code) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: 'https://mytiki.app',
        link: Uri.parse('https://mytiki.com/app/blockchain?ref=' + code),
        dynamicLinkParametersOptions: DynamicLinkParametersOptions(
          shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
        ),
        androidParameters: AndroidParameters(
            packageName: 'com.mytiki.app',
            fallbackUrl: Uri.parse(
                'https://play.google.com/store/apps/details?id=com.mytiki.app')),
        iosParameters: IosParameters(
            bundleId: 'com.mytiki.app',
            fallbackUrl:
                Uri.parse('https://testflight.apple.com/join/pUcjaGK8')),
        googleAnalyticsParameters: GoogleAnalyticsParameters(
          campaign: 'refer',
          medium: 'app',
          source: code,
        ),
        itunesConnectAnalyticsParameters: ItunesConnectAnalyticsParameters(
          affiliateToken: code,
          providerToken: 'app',
          campaignToken: 'refer',
        ),
        socialMetaTagParameters: SocialMetaTagParameters(
          title: 'Join TIKI!',
          description: "It's YOUR data. You can take back control.",
        ));

    final ShortDynamicLink shortLink = await parameters.buildShortLink();
    return shortLink.shortUrl;
  }
}
