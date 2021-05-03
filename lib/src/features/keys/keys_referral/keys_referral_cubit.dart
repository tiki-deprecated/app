/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/repo/repo_api_blockchain_address/repo_api_blockchain_address.dart';
import 'package:app/src/features/repo/repo_api_blockchain_address/repo_api_blockchain_address_refer_rsp.dart';
import 'package:app/src/features/repo/repo_local_ss_current/repo_local_ss_current.dart';
import 'package:app/src/features/repo/repo_local_ss_current/repo_local_ss_current_model.dart';
import 'package:app/src/features/repo/repo_local_ss_user/repo_local_ss_user.dart';
import 'package:app/src/features/repo/repo_local_ss_user/repo_local_ss_user_model.dart';
import 'package:app/src/utils/helper/helper_api_rsp.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'keys_referral_state.dart';

class KeysReferralCubit extends Cubit<KeysReferralState> {
  final RepoLocalSsCurrent _repoLocalSsCurrent;
  final RepoLocalSsUser _repoLocalSsUser;
  final RepoApiBlockchainAddress _repoApiBlockchainAddress;

  KeysReferralCubit(this._repoLocalSsCurrent, this._repoLocalSsUser,
      this._repoApiBlockchainAddress)
      : super(KeysReferralInitial());

  KeysReferralCubit.provide(BuildContext context)
      : _repoLocalSsUser = RepositoryProvider.of<RepoLocalSsUser>(context),
        _repoLocalSsCurrent =
            RepositoryProvider.of<RepoLocalSsCurrent>(context),
        _repoApiBlockchainAddress =
            RepositoryProvider.of<RepoApiBlockchainAddress>(context),
        super(KeysReferralInitial());

  void updateReferer(String referer) {
    emit(KeysReferralInProgress(referer));
  }

  Future<void> getLink() async {
    if (state.link == null) {
      RepoLocalSsCurrentModel current =
          await _repoLocalSsCurrent.find(RepoLocalSsCurrent.key);
      RepoLocalSsUserModel user = await _repoLocalSsUser.find(current.email);
      if (user.referral == null) {
        final DynamicLinkParameters parameters = DynamicLinkParameters(
            uriPrefix: 'https://mytiki.app',
            link: Uri.parse(
                'https://mytiki.com/app/blockchain?ref=' + user.address),
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
        Uri referral = shortLink.shortUrl;
        user.referral = referral;
        await _repoLocalSsUser.save(user.email, user);
        emit(KeysReferralSuccess(state.referer, referral, 0));
      } else
        emit(KeysReferralSuccess(state.referer, user.referral, 0));
    } else
      emit(KeysReferralSuccess(state.referer, state.link, 0));
  }

  Future<void> getCount() async {
    RepoLocalSsCurrentModel current =
        await _repoLocalSsCurrent.find(RepoLocalSsCurrent.key);
    RepoLocalSsUserModel user = await _repoLocalSsUser.find(current.email);
    HelperApiRsp<RepoApiBlockchainAddressReferRsp> apiRsp =
        await _repoApiBlockchainAddress.referCount(user.address);
    if (apiRsp.code == 200) {
      RepoApiBlockchainAddressReferRsp rsp = apiRsp.data;
      emit(KeysReferralSuccess(state.referer, state.link, rsp.count));
    }
  }
}
