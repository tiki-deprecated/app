class ApiAppDataModel {
  int? id;
  late String key;
  late String value;

  ApiAppDataModel({
    required this.id,
    required this.key,
    required this.value,
  });

  ApiAppDataModel.fromMap(Map<String, dynamic> map)
      : this.id = map['id'],
        this.key = map['key'],
        this.value = map['value'];

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'key': this.key,
      'value': this.value,
    };
  }
}
