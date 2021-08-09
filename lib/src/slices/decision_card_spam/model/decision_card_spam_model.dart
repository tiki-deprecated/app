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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DecisionCardSpamModel &&
          runtimeType == other.runtimeType &&
          logoUrl == other.logoUrl &&
          companyName == other.companyName &&
          category == other.category &&
          frequency == other.frequency &&
          sinceYear == other.sinceYear &&
          totalEmails == other.totalEmails &&
          openRate == other.openRate &&
          securityScore == other.securityScore &&
          sensitivityScore == other.sensitivityScore &&
          hackingScore == other.hackingScore &&
          senderEmail == other.senderEmail &&
          senderId == other.senderId;

  @override
  int get hashCode =>
      logoUrl.hashCode ^
      companyName.hashCode ^
      category.hashCode ^
      frequency.hashCode ^
      sinceYear.hashCode ^
      totalEmails.hashCode ^
      openRate.hashCode ^
      securityScore.hashCode ^
      sensitivityScore.hashCode ^
      hackingScore.hashCode ^
      senderEmail.hashCode ^
      senderId.hashCode;
}

enum DecisionCardSpamFrequency { daily, weekly, monthly }
