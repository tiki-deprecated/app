import 'package:app/src/slices/api_app_data/model/api_app_data_model.dart';
import 'package:sqflite_sqlcipher/sqlite_api.dart';

class ApiAppDataRepository {
  static const String _table = 'app_data';
  final Database _database;

  ApiAppDataRepository(this._database);

  Future<ApiAppDataModel?> insert(ApiAppDataModel data) async {
    int dataId = await _database.insert(_table, data.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    data.id = dataId;
    return data;
  }

  Future<List<ApiAppDataModel>> getAll() async {
    final List<Map<String, dynamic>> allMapped = await _database.query(_table);
    return List.generate(
        allMapped.length, (i) => ApiAppDataModel.fromMap(allMapped[i]));
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
    final List<Map<String, Object?>> mappedData =
        await _database.query(_table, where: "id = ?", whereArgs: [id]);
    return mappedData.length > 0
        ? List.generate(mappedData.length,
            (i) => ApiAppDataModel.fromMap(mappedData[i])).first
        : null;
  }

  Future<ApiAppDataModel?> getByKey(String key) async {
    final List<Map<String, Object?>> mappedData =
        await _database.query(_table, where: "key = ?", whereArgs: [key]);
    return mappedData.length > 0
        ? List.generate(mappedData.length,
            (i) => ApiAppDataModel.fromMap(mappedData[i])).first
        : null;
  }
}
