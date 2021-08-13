/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class IntroScreenModelCard {
  final title;
  final subtitle;
  final button;
  final backgroundColor;

  IntroScreenModelCard(
      {required this.title,
      required this.subtitle,
      required this.button,
      required this.backgroundColor})
      : assert(title != ""),
        assert(subtitle != ""),
        assert(button != "");
}
