import 'package:app/src/slices/tiki_screen/tiki_screen_service.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TikiScreenPresenter {
  num get marginHorizontal => 6;
  num get marginGsTop => 16;
  num get marginEmailTop => 2;
  num get marginUpdatesTop => 3;
  num get marginTikiBoxTop => 2;
  num get marginCardsTop => 3;
  num get marginVersionTop => 2;
  num get marginLogOutVertical => 2;

  num get marginTikiBoxCounterTop => 3;
  num get marginTikiBoxReferTop => 4;
  num get marginTikiBoxReferCodeTop => 1.5;
  num get marginTikiBoxReferCodeHorizontal => 11;
  num get marginTikiBoxReferCountTop => 1;
  num get marginTikiBoxShareTop => 4;
  num get marginTikiBoxShareBottom => 5;

  num get fontSizeHeading => 30;
  num get fontSizeTikiBoxCounterNum => 70;
  num get fontSizeTikiBoxCounterText => 14;
  num get fontSizeTikiBoxReferText => 14;
  num get fontSizeTikiBoxReferCode => 14;
  num get fontSizeTikiBoxReferShare => 18;
  num get fontSizeTikiBoxReferCount => 13;

  num get fontSizeCardTitle => 17;
  num get fontSizeCardText => 12;
  num get fontSizeCardCta => 13;

  num get fontSizeVersion => 11;
  num get fontSizeLogout => 15;

  num get fontSizeEmail => 13.5;
  num get fontSizeSee => 14;

  get textGs => "Get started";
  get textUpdates => "TIKI updates";
  get textLogout => "Log out";

  get textTikiBoxCounter => "people joined the TIKI tribe";
  get textTikiBoxReferL1 => "Share your TIKI code and get";
  get textTikiBoxReferL2 => "\$5 for every 10 people who join.";
  get textTikiBoxReferCode => "YOUR CODE:";
  get textTikiBoxReferShare => "SHARE";
  get textTikiBoxReferCount => "people joined";

  get textCardReleaseTitle => "Coming next";
  get textCardReleaseText => "See which companies \nemail you";
  get textCardReleaseCtaText => "Read More";
  get textCardReleaseCtaUrl => "https://mytiki.com/roadmap";

  get textCardNewsTitle => "Latest news";
  get textCardNewsText =>
      "For the latest news and updates, check out our blog.";
  get textCardNewsCtaText => "Read More";
  get textCardNewsCtaUrl => "https://mytiki.com/blog";

  get textCardCommunityTitle => "TIKI tribe";
  get textCardCommunityText =>
      "Join our community of TIKI-nites from around the globe.";

  get textCardFollowTitle => "Follow us";
  get textCardFollowText =>
      "You can find helpful and fun stuff on our channels.";

  get textTikiBoxReferShareMessage => "It's your data. Get paid for it.";

  get textSeeData => "See what data \nGmail has on you";

  final service;

  TikiScreenPresenter(this.service);

  get bgcolor => Color(0XFFF4F4F4);

  num get emailButtonMarginBottom => 2;

  ChangeNotifierProvider<TikiScreenService> render() {
    return ChangeNotifierProvider.value(
        value: service, child: TikiScreenLayout());
  }
}
