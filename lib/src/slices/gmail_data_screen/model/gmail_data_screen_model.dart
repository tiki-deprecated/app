class GmailDataScreenModel {
  List<InfoCardData> infoCards = [];
}

class InfoCardData {
  final InfoCardCoverData coverData;
  final InfoCardDataModel cardData;

  InfoCardData({required this.coverData, required this.cardData});
}

class InfoCardDataModel {
  final InfoCardContentDataModel cardContentData;
  final InfoCardCtaDataModel cardCtaData;

  InfoCardDataModel(this.cardContentData, this.cardCtaData);
}

class InfoCardCtaDataModel {
  late List<InfoCardContentExplanationModel> ctaExplanation;
  final String buttonText;
  final String btnActionUrl;

  InfoCardCtaDataModel(this.ctaExplanation, this.buttonText, this.btnActionUrl);
}

class InfoCardContentDataModel {
  late List<InfoCardContentExplanationModel> cardContent;
  late List<InfoCardContenTheySayModel> theySay;
}

class InfoCardContentExplanationModel {
  final String text;
  final String? url;

  InfoCardContentExplanationModel(this.text, this.url);
}

class InfoCardContenTheySayModel {
  final String image;
  final String text;

  InfoCardContenTheySayModel(this.image, this.text);
}

class InfoCardCoverData {
  String image;
  String subtitle;
  String bigTextLighter;
  String bigTextDarker;
  String subText;

  InfoCardCoverData({
    required this.image,
    required this.subtitle,
    required this.bigTextLighter,
    required this.bigTextDarker,
    required this.subText,
  });
}

class InfoCardTopHeaderModel {
  final String logoImage;
  final String title;
  final String shareMessage;
  final String socialMediaImg;

  InfoCardTopHeaderModel(
      {required this.logoImage,
      required this.title,
      required this.shareMessage,
      required this.socialMediaImg});
}
