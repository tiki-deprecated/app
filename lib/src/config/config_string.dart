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
}

class _ConfigStringIntroControl {
  final String title = "Take control of your data";
  final String subtitle =
      "TIKI is a free app that allows you to see, control and monetise your data.";
  final String button = "NEXT";

  const _ConfigStringIntroControl();
}

class _ConfigStringIntroEarn {
  final String title = "Start earning money";
  final String subtitle =
      "You can also choose to earn  money from your data. This is optional.";
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
