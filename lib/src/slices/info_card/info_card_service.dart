import 'package:app/src/slices/info_card/info_card_controller.dart';
import 'package:app/src/slices/info_card/info_card_presenter.dart';
import 'package:app/src/slices/info_card/model/info_card_model.dart';
import 'package:app/src/slices/info_card/ui/info_card_layout.dart';
import 'package:flutter/material.dart';

class InfoCardService extends ChangeNotifier {
  late InfoCardController controller;
  late InfoCardPresenter presenter;
  late InfoCardData model;

  InfoCardLayout getUIFromJson(cardsData) {
    var coverData = cardsData['coverData'];
    var cardData = cardsData['cardData'];
    this.model = InfoCardData(
        cardData: getInfoCardData(cardData),
        coverData: getInfoCoverData(coverData));
    return this.presenter.getUI();
  }

  InfoCardDataModel getInfoCardData(cardData) {
    var cardContentData = cardData['cardContentData'];
    var cardCtaData = cardData['cardCtaData'];
    return InfoCardDataModel(
        cardContentData: getInfoCardContentData(cardContentData),
        cardCtaData: getInfoCardCtaData(cardCtaData));
  }

  InfoCardCoverData getInfoCoverData(coverData) {
    return InfoCardCoverData(
        subtitle: coverData['subtitle'],
        subText: coverData['subText'],
        bigTextLighter: coverData['bigTextLighter'],
        image: coverData['image'],
        bigTextDarker: coverData['bigTextDarker']);
  }

  InfoCardContentDataModel getInfoCardContentData(cardContentData) {
    return InfoCardContentDataModel(
        cardContent: cardContentData['richTextExplanation'],
        theySay: cardContentData['theySay']);
  }

  InfoCardCtaDataModel getInfoCardCtaData(cardCtaData) {}
}
