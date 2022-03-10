import '../../../utils/json/json_object.dart';

class ApiAppDataModel extends JsonObject {
  int? id;
  late String key;
  late String value;

  ApiAppDataModel({
    required this.id,
    required this.key,
    required this.value,
  });

  ApiAppDataModel.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      id = json['id'];
      key = json['key'];
      value = json['value'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'key': key,
        'value': value,
      };
}
