/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class ConfigString {
  static const _ConfigStringIntroControl introControl =
      _ConfigStringIntroControl();
  static const _ConfigStringIntroEarn introEarn = _ConfigStringIntroEarn();
  static const _ConfigStringIntroTogether introTogether =
      _ConfigStringIntroTogether();
  static const _ConfigStringLoginEmail loginEmail = _ConfigStringLoginEmail();
  static const _ConfigStringLoginInbox loginInbox = _ConfigStringLoginInbox();
  static const _ConfigStringKeysNew keysNew = _ConfigStringKeysNew();
}

class _ConfigStringIntroControl {
  final String title = "Take control of your data";
  final String subtitle =
      "TIKI is a free app that allows you to see, control and monetize your data.";
  final String button = "NEXT";

  const _ConfigStringIntroControl();
}

class _ConfigStringIntroEarn {
  final String title = "Start earning money";
  final String subtitle =
      "You can also choose to earn money from your data. This is optional.";
  final String button = "NEXT";

  const _ConfigStringIntroEarn();
}

class _ConfigStringIntroTogether {
  final String title = "We're stronger together";
  final String subtitle =
      "You are now part of the TIKI tribe! I’m Tiki and I am here to help you take back your share.";
  final String button = "GET STARTED";

  const _ConfigStringIntroTogether();
}

class _ConfigStringLoginEmail {
  final String title = "Hey, nice to see you here";
  final String cta = "Enter your email below to begin.";
  final String placeholder = "Your email";
  final String error = "Please enter a valid email";
  final String button = "CONTINUE";

  const _ConfigStringLoginEmail();
}

class _ConfigStringLoginInbox {
  final String title = "Great, now check your inbox";
  final String sentTo = "I sent an email with a link to";
  final String didReceive = "Didn't receive it?";
  final String resend = "Resend now";
  final String back = "Back";

  const _ConfigStringLoginInbox();
}

class _ConfigStringKeysNew {
  final String genTitle = "Just one sec..";
  final String genSubtitle = "I'm securing your account";
  final String saveTitle = "Save your keys";
  final String saveSubtitle =
      "We advise you to save your TIKI keys for when you swap mobile devices.";
  final String restoreButton = "Already have an account?";
  final String copyButton = "COPY";
  final String copyId = "TIKI ID";
  final String copyDataKey = "DATA KEY";
  final String copySignKey = "SIGN KEY";
  final String saveButton = "SAVE & CONTINUE";
  final String skipButton = "SKIP SAVING";
  final String downloadTitle = "TIKI Keys";
  final String downloadSubtitle =
      "These are your security keys. Save them somewhere safe. DO NOT SHARE.";
  final String downloadId = "TIKI ID: ";

  const _ConfigStringKeysNew();
}
