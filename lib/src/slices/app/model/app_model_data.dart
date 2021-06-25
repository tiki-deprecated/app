class AppModelData {
  int? id;
  String? key;
  String? value;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{'key': key, 'value': value.toString()};
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  AppModelData();

  AppModelData.fromMap(Map<String, Object?> map) {
    id = int.tryParse(map['id'].toString());
    key = map['key'].toString();
    value = map['value'].toString();
  }

  String getTable() => "app_data";
}