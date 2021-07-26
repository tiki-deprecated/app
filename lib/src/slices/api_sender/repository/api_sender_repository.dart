import 'package:app/src/slices/api_sender/model/api_sender_model.dart';
import 'package:app/src/slices/api_sqlite/api_sqlite_service.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class ApiSenderRepository {
  String _table = 'sender';

  Future<ApiSenderModel> insert(ApiSenderModel sender) async {
    final db = await ApiSqliteService().db;
    int senderId = await db.insert(_table, sender.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    sender.senderId = senderId;
    return sender;
  }

  Future<List<ApiSenderModel>> get(ApiSenderModel subject) async {
    final db = await ApiSqliteService().db;
    var subjectMap = subject.toMap();
    String where = subjectMap.keys.join(' = ? AND ') + "= ?";
    List<String?> whereArgs = subjectMap.values
        .map((entry) => entry != null ? "'${entry.toString()}'" : 'NULL')
        .toList();
    final List<Map<String, Object?>> mappedSenders =
        await db.query(_table, where: where, whereArgs: whereArgs);
    return List.generate(
        mappedSenders.length, (i) => ApiSenderModel.fromMap(mappedSenders[i]));
  }

  Future<List<ApiSenderModel>> getAll() async {
    final db = await ApiSqliteService().db;
    final List<Map<String, dynamic>> allMapped = await db.query(_table);
    return List.generate(
        allMapped.length, (i) => ApiSenderModel.fromMap(allMapped[i]));
  }

  Future<ApiSenderModel> update(ApiSenderModel sender) async {
    final db = await ApiSqliteService().db;
    await db.update(
      _table,
      sender.toMap(),
      where: 'sender_id = ?',
      whereArgs: [sender.senderId],
    );
    return sender;
  }

  Future<void> delete(int id) async {
    final db = await ApiSqliteService().db;
    await db.delete(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<ApiSenderModel>> getByParams(List<List<String?>> params) async {
    final db = await ApiSqliteService().db;
    String where = '';
    List<String?> whereArgs = [];
    if (params.isNotEmpty) {
      List<String?> whereParams = [];
      params.forEach((param) {
        if (param[0] != null && param[1] != null) {
          whereParams.add(param[0]! + ' ' + param[1]! + ' ?');
          whereArgs.add(param[2] != null ? "'${param[2].toString()}'" : 'NULL');
        }
      });
      where = whereArgs.join(' AND ');
    }
    final List<Map<String, Object?>> mappedSenders =
        await db.query(_table, where: where, whereArgs: whereArgs);
    return List.generate(
        mappedSenders.length, (i) => ApiSenderModel.fromMap(mappedSenders[i]));
  }
}
