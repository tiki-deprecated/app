import 'package:app/src/slices/api_message/model/api_message_model.dart';
import 'package:app/src/slices/api_sqlite/api_sqlite_service.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class ApiMessageRepository {
  String _table = 'message';

  Future<ApiMessageModel> insert(ApiMessageModel sender) async {
    final db = await ApiSqliteService().db;
    int senderId = await db.insert(_table, sender.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    sender.senderId = senderId;
    return sender;
  }

  Future<List<ApiMessageModel>> get(ApiMessageModel subject) async {
    final db = await ApiSqliteService().db;
    var subjectMap = subject.toMap();
    String where = subjectMap.keys.join(' = ?,');
    List<String> whereArgs =
        subjectMap.entries.map((entry) => entry.toString()).toList();
    final List<Map<String, Object?>> mappedSenders =
        await db.query(_table, where: where, whereArgs: whereArgs);
    return List.generate(
        mappedSenders.length, (i) => ApiMessageModel.fromMap(mappedSenders[i]));
  }

  Future<List<ApiMessageModel>> getAll() async {
    final db = await ApiSqliteService().db;
    final List<Map<String, dynamic>> allMapped = await db.query(_table);
    return List.generate(
        allMapped.length, (i) => ApiMessageModel.fromMap(allMapped[i]));
  }

  Future<ApiMessageModel> update(ApiMessageModel message) async {
    final db = await ApiSqliteService().db;
    await db.update(
      _table,
      message.toMap(),
      where: 'message_id = ?',
      whereArgs: [message.senderId],
    );
    return message;
  }

  Future<void> delete(int id) async {
    final db = await ApiSqliteService().db;
    await db.delete(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
