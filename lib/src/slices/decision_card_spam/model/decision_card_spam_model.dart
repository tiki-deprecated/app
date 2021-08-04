class DecisionCardSpamModel {
  String? logoUrl;
  String? companyName;
  String? category;
  String? frequency;
  String? sinceYear;
  int? totalEmails;
  double? openRate;
  double? securityScore;
  double? sensitivityScore;
  double? hackingScore;
  String? senderEmail;
  late int senderId;

  DecisionCardSpamModel({
    this.logoUrl,
    this.category,
    required this.companyName,
    required this.frequency,
    this.sinceYear,
    this.totalEmails,
    required this.openRate,
    this.securityScore,
    this.sensitivityScore,
    this.hackingScore,
    this.senderEmail,
    required this.senderId,
  });
}

enum DecisionCardSpamFrequency { daily, weekly, monthly }
