class IntroSlideModel{
  final title;
  final subtitle;
  final button;
  final backgroundColor;

  IntroSlideModel(
      {required this.title, required this.subtitle, required this.button, required this.backgroundColor})
      : assert(title != ""),
        assert(subtitle != ""),
        assert(button != "");
}