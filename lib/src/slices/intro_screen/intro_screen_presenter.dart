import 'package:provider/provider.dart';

import 'intro_screen_service.dart';
import 'res/intro_slides_strings.dart' as introStrings;
import 'ui/intro_screen_layout.dart';

class IntroScreenPresenter {
  final IntroScreenService service;

  IntroScreenPresenter(this.service);

  get skipText => introStrings.skip;
  get currentSlideIndex => service.model.getCurrentSlideIndex();
  get buttonText => introStrings.slides[currentSlideIndex]["button"];
  get subtitle => introStrings.slides[currentSlideIndex]["subtitle"];
  get title => introStrings.slides[currentSlideIndex]["title"];

  num get titleFontSize => 30;
  num get marginTopText => 2.5;
  num get marginTopButton => 5;
  num get marginTopTitle => 15;
  num get marginTopSkip => 2;
  num get marginRightText => 10;

  ChangeNotifierProvider<IntroScreenService> render() {
    return ChangeNotifierProvider.value(value: service, child: IntroScreen());
  }
}
