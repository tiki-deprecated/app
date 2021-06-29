import 'package:app/src/slices/info_card/info_card_controller.dart';
import 'package:app/src/slices/info_card/info_card_presenter.dart';
import 'package:app/src/slices/info_card/model/info_card_model.dart';
import 'package:app/src/slices/info_card/ui/info_card_layout.dart';
import 'package:flutter/material.dart';

class InfoCardService extends ChangeNotifier {
  late InfoCardController controller;
  late InfoCardPresenter presenter;
  late InfoCardData model;

  InfoCardLayout getUIFromJson(data) {
    var coverData = data['coverData'];
    var cardData = data['cardData'];
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
        topHeader: getInfoCardTopHeader(coverData['topHeader']),
        subtitle: coverData['subtitle'],
        subText: coverData['subText'],
        bigTextLighter: coverData['bigTextLighter'],
        image: coverData['image'],
        bigTextDarker: coverData['bigTextDarker']);
  }

  InfoCardContentDataModel getInfoCardContentData(cardContentData) {
    List<Map> richTextExplanationMap = cardContentData['richTextExplanation'];
    List<InfoCardContentExplanationModel> cardContent = [];
    richTextExplanationMap.forEach((element) {
      cardContent.add(InfoCardContentExplanationModel(
          text: element["text"], url: element["url"]));
    });

    List<Map> theySayMap = cardContentData['theySay'];
    List<InfoCardContentTheySayModel> theySay = [];
    theySayMap.forEach((element) {
      theySay.add(InfoCardContentTheySayModel(
          text: element["text"], image: element["image"]));
    });

    List<Map> youShouldKnowMap = cardContentData['youShouldKnow'];
    List<InfoCardContentYouShouldKnowModel> youShouldKnow = [];
    youShouldKnowMap.forEach((element) {
      youShouldKnow.add(InfoCardContentYouShouldKnowModel(
          text: element["text"], image: element["image"]));
    });

    return InfoCardContentDataModel(
        cardContent: cardContent,
        theySay: theySay,
        youShouldKnow: youShouldKnow);
  }

  InfoCardTopHeaderModel getInfoCardTopHeader(coverData) {
    return InfoCardTopHeaderModel(
        title: coverData['title'],
        logoImage: coverData['image'],
        socialMediaImg: coverData['sharecard']['image'],
        shareMessage: coverData['sharecard']['message']);
  }

  InfoCardCtaDataModel getInfoCardCtaData(cardCtaData) {
    List<Map> richTextExplanationMap = cardCtaData['richTextExplanation'];
    List<InfoCardContentExplanationModel> ctaExplanation = [];
    richTextExplanationMap.forEach((element) {
      ctaExplanation.add(InfoCardContentExplanationModel(
          text: element["text"], url: element["url"]));
    });

    return InfoCardCtaDataModel(
        buttonText: cardCtaData['buttonText'],
        ctaExplanation: ctaExplanation,
        btnActionUrl: cardCtaData['btnActionUrl']);
  }
}
