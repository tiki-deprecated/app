import 'package:app/src/slices/info_card/info_card_controller.dart';
import 'package:app/src/slices/info_card/info_card_presenter.dart';
import 'package:app/src/slices/info_card/model/info_card_model.dart';
import 'package:app/src/slices/info_card/ui/info_card_layout.dart';
import 'package:flutter/material.dart';

class InfoCardService extends ChangeNotifier {
  late InfoCardController controller;
  late InfoCardPresenter presenter;
  late InfoCardDataModel model;

  InfoCardLayout getUIFromJson(cardsData) {}
}
