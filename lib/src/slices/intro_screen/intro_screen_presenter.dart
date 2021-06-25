import 'package:provider/provider.dart';

import 'intro_screen_service.dart';
import 'res/intro_slides_strings.dart' as introStrings;
import 'ui/intro_screen_layout.dart';

class IntroScreenPresenter {
  final IntroScreenService service;

  IntroScreenPresenter(this.service);

  get currentSlideIndex => service.model.getCurrentSlideIndex();

  get textSkip => introStrings.skip;
  get textButton => introStrings.slides[currentSlideIndex]["button"];
  get textSubtitle => introStrings.slides[currentSlideIndex]["subtitle"];
  get textTitle => introStrings.slides[currentSlideIndex]["title"];

  num get fontSizeSkip => 15;
  num get fontSizeTitle => 34;
  num get fontSizeSubtitle => 15;
  num get fontSizeButton => 15;

  num get marginSkipTop => 2;
  num get marginTitleTop => 15;
  num get marginTextTop => 2;
  num get marginTextRight => 12;
  num get marginButtonTop => 5;
  num get marginHorizontal => 6;

  ChangeNotifierProvider<IntroScreenService> render() {
    return ChangeNotifierProvider.value(value: service, child: IntroScreen());
  }
}
