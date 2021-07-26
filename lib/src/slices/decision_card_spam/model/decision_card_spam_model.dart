class DecisionCardSpamModel {
  String? logoUrl;
  String? companyName;
  String? category;
  DecisionCardSpamFrequency? frequency;
  double? openRate;
  double? securityScore;
  double? sensitivityScore;
  double? hackingScore;
  late int senderId;

  DecisionCardSpamModel({
    this.logoUrl,
    this.category,
    required this.companyName,
    required this.frequency,
    required this.openRate,
    this.securityScore,
    this.sensitivityScore,
    this.hackingScore,
    required this.senderId,
  });
}

enum DecisionCardSpamFrequency { daily, weekly, monthly }
