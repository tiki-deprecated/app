import 'package:provider/provider.dart';

import 'intro_screen_service.dart';
import 'res/intro_slides_strings.dart' as introStrings;
import 'ui/intro_screen_layout.dart';

class IntroScreenPresenter {
  final IntroScreenService service;

  Map margins = {};

  IntroScreenPresenter(this.service);

  get skipText => introStrings.skip;
  get currentSlideIndex => service.model.getCurrentSlideIndex();
  get buttonText => introStrings.slides[currentSlideIndex]["button"];
  get subtitle => introStrings.slides[currentSlideIndex]["subtitle"];
  get title => introStrings.slides[currentSlideIndex]["title"];

  ChangeNotifierProvider<IntroScreenService> render() {
    return ChangeNotifierProvider.value(value: service, child: IntroScreen());
  }
}
