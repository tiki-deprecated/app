abstract class TikiDbModel {
  int? id;

  String getTable();

  TikiDbModel();

  TikiDbModel.fromMap(Map map);

  toMap();
}
