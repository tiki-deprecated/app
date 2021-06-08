

import 'package:app/new_src/use_cases/intro_screen/intro_screen_controller.dart';

import '../../presenter.dart';
import 'model/intro_screen_model.dart';
import 'ui/intro_screen.dart';

class IntroScreenPresenter extends Presenter{

  IntroScreen render(IntroScreenController controller, IntroScreenModel model){
    var slide = model.getCurrentSlide();
    return IntroScreen(
      controller: controller,
      backgroundColor : slide.backgroundColor,
      title : slide.title,
      subtitle : slide.subtitle,
      button : slide.button,
      currentSlide: model.getCurrentSlideIndex(),
      totalSlides: model.getTotalSlides(),
    );
  }

}
