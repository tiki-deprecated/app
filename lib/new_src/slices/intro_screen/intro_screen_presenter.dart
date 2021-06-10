import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:provider/provider.dart';
import 'intro_screen_service.dart';
import 'res/intro_slides_strings.dart' as introStrings;

import 'ui/intro_screen.dart';

class IntroScreenPresenter{

  final IntroScreenService service;
  final double marginTopText = 2.5 * PlatformRelativeSize.blockVertical;
  final double marginTopButton = 5 * PlatformRelativeSize.blockVertical;
  final double marginTopTitle = 15 * PlatformRelativeSize.blockVertical;
  final double marginTopSkip = 2 * PlatformRelativeSize.blockVertical;
  final double marginRightText = 10 * PlatformRelativeSize.blockHorizontal;

  IntroScreenPresenter(this.service);

  get skipText => introStrings.skip;
  get currentSlideIndex => service.model.getCurrentSlideIndex();
  get buttonText => introStrings.slides[currentSlideIndex]["button"];
  get subtitle => introStrings.slides[currentSlideIndex]["subtitle"];
  get title => introStrings.slides[currentSlideIndex]["title"];
  ChangeNotifierProvider<IntroScreenService> render(){
    return ChangeNotifierProvider.value(
        value: service,
        child: IntroScreen()
    );
  }

}