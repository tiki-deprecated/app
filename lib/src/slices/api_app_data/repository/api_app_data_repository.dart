import 'package:app/src/slices/api_app_data/model/api_app_data_model.dart';
import 'package:app/src/slices/api_sqlite/api_sqlite_service.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class ApiAppDataRepository {
  String _table = 'app_data';

  Future<ApiAppDataModel> insert(ApiAppDataModel data) async {
    final db = await ApiSqliteService().db;
    int dataId = await db.insert(_table, data.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    data.id = dataId;
    return data;
  }

  Future<List<ApiAppDataModel>> getAll() async {
    final db = await ApiSqliteService().db;
    final List<Map<String, dynamic>> allMapped = await db.query(_table);
    return List.generate(
        allMapped.length, (i) => ApiAppDataModel.fromMap(allMapped[i]));
  }

  Future<ApiAppDataModel> update(ApiAppDataModel data) async {
    final db = await ApiSqliteService().db;
    await db.update(
      _table,
      data.toMap(),
      where: 'id = ?',
      whereArgs: [data.id],
    );
    return data;
  }

  Future<void> delete(int id) async {
    final db = await ApiSqliteService().db;
    await db.delete(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<ApiAppDataModel?> getById(int id) async {
    final db = await ApiSqliteService().db;
    final List<Map<String, Object?>> mappedData =
        await db.query(_table, where: "id = ?", whereArgs: [id]);
    return mappedData.length > 0
        ? List.generate(mappedData.length,
            (i) => ApiAppDataModel.fromMap(mappedData[i])).first
        : null;
  }

  Future<ApiAppDataModel?> getByKey(String key) async {
    final db = await ApiSqliteService().db;
    final List<Map<String, Object?>> mappedData =
        await db.query(_table, where: "key = ?", whereArgs: [key]);
    return mappedData.length > 0
        ? List.generate(mappedData.length,
            (i) => ApiAppDataModel.fromMap(mappedData[i])).first
        : null;
  }
}
