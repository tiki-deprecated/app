import 'package:app/new_src/use_cases/intro_screen/model/intro_slide_model.dart';

import '../../../model.dart';

/// The [Model] for [IntroScreenUseCase]
class IntroScreenModel extends Model {
  final List<IntroSlideModel> _slides = [];
  int _currentSlide = 0;

  addSlide(IntroSlideModel slide){
    _slides.add(slide);
  }

  getSlideAt(int index){
    return _slides[index];
  }

  getCurrentSlide(){
    return _slides[_currentSlide];
  }

  getNextSlide(){
    return _slides[++_currentSlide];
  }

  getPreviousSlide(){
    return _slides[--_currentSlide];
  }
}
