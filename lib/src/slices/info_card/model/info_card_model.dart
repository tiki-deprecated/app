class InfoCardData {
  final InfoCardCoverData coverData;
  final InfoCardDataModel cardData;

  InfoCardData({required this.coverData, required this.cardData});
}

class InfoCardDataModel {
  final InfoCardContentDataModel cardContentData;
  final InfoCardCtaDataModel cardCtaData;

  InfoCardDataModel({required this.cardContentData, required this.cardCtaData});
}

class InfoCardCtaDataModel {
  late List<InfoCardContentExplanationModel> ctaExplanation;
  final String buttonText;
  final String btnActionUrl;

  InfoCardCtaDataModel(
      {required this.ctaExplanation,
      required this.buttonText,
      required this.btnActionUrl});
}

class InfoCardContentDataModel {
  final List<InfoCardContentExplanationModel> cardContent;
  final List<InfoCardContenTheySayModel> theySay;
  final List<InfoCardContenYouShouldKnowModel> youShouldKnow;

  InfoCardContentDataModel(
      {required this.cardContent,
      required this.theySay,
      required this.youShouldKnow});
}

class InfoCardContentExplanationModel {
  final String text;
  final String? url;

  InfoCardContentExplanationModel({required this.text, required this.url});
}

class InfoCardContenTheySayModel {
  final String image;
  final String text;

  InfoCardContenTheySayModel({required this.image, required this.text});
}

class InfoCardContenYouShouldKnowModel {
  final String image;
  final String text;

  InfoCardContenYouShouldKnowModel({required this.image, required this.text});
}

class InfoCardCoverData {
  InfoCardTopHeaderModel topHeader;
  String image;
  String subtitle;
  String bigTextLighter;
  String bigTextDarker;
  String subText;

  InfoCardCoverData({
    required this.topHeader,
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
