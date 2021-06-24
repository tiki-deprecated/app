/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api/helper_api_rsp.dart';
import 'package:app/src/slices/app/model/app_model_current.dart';
import 'package:app/src/slices/app/model/app_model_user.dart';
import 'package:app/src/slices/app/repository/secure_storage_repository_current.dart';
import 'package:app/src/slices/app/repository/secure_storage_repository_user.dart';
import 'package:app/src/slices/keys_screen/repo_api_blockchain_address/repo_api_blockchain_address.dart';
import 'package:app/src/slices/keys_screen/repo_api_blockchain_address/repo_api_blockchain_address_refer_rsp.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'keys_referral_state.dart';

class KeysReferralCubit extends Cubit<KeysReferralState> {
  final SecureStorageRepositoryCurrent _secureStorageRepositoryCurrent;
  final SecureStorageRepositoryUser _repoLocalSsUser;
  final RepoApiBlockchainAddress _repoApiBlockchainAddress;

  KeysReferralCubit(this._secureStorageRepositoryCurrent, this._repoLocalSsUser,
      this._repoApiBlockchainAddress)
      : super(KeysReferralInitial());

  KeysReferralCubit.provide(BuildContext context)
      : _repoLocalSsUser =
            RepositoryProvider.of<SecureStorageRepositoryUser>(context, listen:false),
        _secureStorageRepositoryCurrent =
            RepositoryProvider.of<SecureStorageRepositoryCurrent>(context, listen:false),
        _repoApiBlockchainAddress =
            RepositoryProvider.of<RepoApiBlockchainAddress>(context, listen:false),
        super(KeysReferralInitial());

  void updateReferer(String referer) {
    emit(KeysReferralInProgress(referer));
  }

  Future<void> getLink() async {
    if (state.link == null) {
      AppModelCurrent current = await _secureStorageRepositoryCurrent
          .find(SecureStorageRepositoryCurrent.key);
      AppModelUser user = await _repoLocalSsUser.find(current.email!);
      if (user.referral == null) {
        final DynamicLinkParameters parameters = DynamicLinkParameters(
            uriPrefix: 'https://mytiki.app',
            link: Uri.parse(
                'https://mytiki.com/app/blockchain?ref=' + user.address!),
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
        await _repoLocalSsUser.save(user.email!, user);
        emit(KeysReferralSuccess(state.referer, referral, 0));
      } else
        emit(KeysReferralSuccess(state.referer, user.referral, 0));
    } else
      emit(KeysReferralSuccess(state.referer, state.link, 0));
  }

  Future<void> getCount() async {
    AppModelCurrent current = await _secureStorageRepositoryCurrent
        .find(SecureStorageRepositoryCurrent.key);
    AppModelUser user = await _repoLocalSsUser.find(current.email!);
    HelperApiRsp<RepoApiBlockchainAddressReferRsp> apiRsp =
        await _repoApiBlockchainAddress.referCount(user.address);
    if (apiRsp.code == 200) {
      RepoApiBlockchainAddressReferRsp rsp = apiRsp.data;
      emit(KeysReferralSuccess(state.referer, state.link, rsp.count));
    }
  }
}
