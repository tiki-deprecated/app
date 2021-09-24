import 'package:sqflite_sqlcipher/sqlite_api.dart';

import '../model/api_app_data_model.dart';

class ApiAppDataRepository {
  static const String _table = 'app_data';
  final Database _database;

  ApiAppDataRepository(this._database);

  Future<ApiAppDataModel?> insert(ApiAppDataModel data) async {
    int dataId = await _database.insert(_table, data.toMap());
    data.id = dataId;
    return data;
  }

  Future<ApiAppDataModel> update(ApiAppDataModel data) async {
    await _database.update(
      _table,
      data.toMap(),
      where: 'id = ?',
      whereArgs: [data.id],
    );
    return data;
  }

  Future<void> delete(int id) async {
    await _database.delete(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<ApiAppDataModel?> getById(int id) async {
    final List<Map<String, Object?>> rows =
        await _database.query(_table, where: "id = ?", whereArgs: [id]);
    if (rows.isEmpty) return null;
    return ApiAppDataModel.fromMap(rows[0]);
  }

  Future<ApiAppDataModel?> getByKey(String key) async {
    final List<Map<String, Object?>> rows =
        await _database.query(_table, where: "key = ?", whereArgs: [key]);
    if (rows.isEmpty) return null;
    return ApiAppDataModel.fromMap(rows[0]);
  }

  deleteByKey(String key) async {
    await _database.delete(_table, where: "key = ?", whereArgs: [key]);
  }
}
