/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

part of 'keys_referral_cubit.dart';

abstract class KeysReferralState extends Equatable {
  final String? referer;
  final Uri? link;
  final int? count;

  const KeysReferralState(this.referer, this.link, this.count);

  @override
  List<Object?> get props => [referer, link, count];
}

class KeysReferralInitial extends KeysReferralState {
  const KeysReferralInitial() : super(null, null, null);
}

class KeysReferralInProgress extends KeysReferralState {
  const KeysReferralInProgress(String referer) : super(referer, null, null);
}

class KeysReferralSuccess extends KeysReferralState {
  const KeysReferralSuccess(String? referer, Uri? link, int? count)
      : super(referer, link, count);
}
