import 'package:app/src/features/intro_slider/intro_slider_model.dart';
import 'package:rxdart/rxdart.dart';

class IntroSliderBloc {
  IntroSliderModel introSliderModel = IntroSliderModel([], 0);
  BehaviorSubject<IntroSliderModel>? _subjectIntroSlider;

  IntroSliderBloc(this.introSliderModel) {
    _subjectIntroSlider =
        new BehaviorSubject<IntroSliderModel>.seeded(introSliderModel);
  }

  Observable<IntroSliderModel> get introSliderObservable =>
      _subjectIntroSlider!.stream;

  void increment() {
    if (introSliderModel.pos < introSliderModel.content.length - 1) {
      introSliderModel.pos++;
      _subjectIntroSlider!.sink.add(introSliderModel);
    }
  }

  void decrement() {
    if (introSliderModel.pos > 0) {
      introSliderModel.pos--;
      _subjectIntroSlider!.sink.add(introSliderModel);
    }
  }

  void dispose() {
    _subjectIntroSlider!.close();
  }
}
