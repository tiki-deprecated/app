class IntroSlideModel{
  final title;
  final subtitle;
  final button;

  IntroSlideModel(
      {required this.title, required this.subtitle, required this.button})
      : assert(title != ""),
        assert(subtitle != ""),
        assert(button != "");
}