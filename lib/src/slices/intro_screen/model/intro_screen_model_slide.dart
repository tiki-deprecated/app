class IntroScreenModelSlide{
  final title;
  final subtitle;
  final button;
  final backgroundColor;

  IntroScreenModelSlide(
      {required this.title, required this.subtitle, required this.button, required this.backgroundColor})
      : assert(title != ""),
        assert(subtitle != ""),
        assert(button != "");
}