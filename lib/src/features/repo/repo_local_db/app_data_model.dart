import 'package:app/src/features/repo/repo_local_db/repo_local_db_model.dart';

class AppData extends TikiDbModel {
  String? key;
  String? value;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{'key': key, 'value': value.toString()};
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  AppData();

  AppData.fromMap(Map<String, Object?> map) {
    id = int.tryParse(map['id'].toString());
    key = map['key'].toString();
    value = map['value'].toString();
  }

  @override
  String getTable() => "app_data";
}
