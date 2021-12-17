import 'bottomsheet_modal_controller.dart';
import 'bottomsheet_modal_presenter.dart';

class BottomSheetModalService{
  final BottomSheetModalController controller;
  final BottomSheetModalPresenter presenter;

  BottomSheetModalService({
    required this.controller,
    required this.presenter
  });
}