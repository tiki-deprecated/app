import '../../use_case.dart';
import 'intro_screen_controller.dart';
import 'model/intro_screen_model.dart';
import 'intro_screen_presenter.dart';

class IntroScreenUseCase extends UseCase {
  late IntroScreenPresenter _presenter;
  late IntroScreenModel _model;
  late IntroScreenController _controller;

  IntroScreenUseCase() {
    _presenter = IntroScreenPresenter();
    _model = IntroScreenModel();
    _controller = IntroScreenController();
  }

  /// Creates the [IntroScreenModel]
  ///
  /// Creates the [IntroSlideModel]s that will be used in [IntroScreenModel].
  createSlidesData(){

  }


}




