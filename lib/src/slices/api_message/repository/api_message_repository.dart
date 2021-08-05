import 'package:app/src/slices/api_message/model/api_message_model.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class ApiMessageRepository {
  static const String _table = 'message';
  final Database _database;

  ApiMessageRepository(this._database);

  Future<ApiMessageModel> insert(ApiMessageModel sender) async {
    int senderId = await _database.insert(_table, sender.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    sender.senderId = senderId;
    return sender;
  }

  Future<List<ApiMessageModel>> get(ApiMessageModel subject) async {
    var subjectMap = subject.toMap();
    String where = subjectMap.keys.join(' = ? AND ') + "= ?";
    List<String?> whereArgs = subjectMap.values
        .map((entry) => entry != null ? "${entry.toString()}" : 'NULL')
        .toList();
    final List<Map<String, Object?>> mappedSenders =
        await _database.query(_table, where: where, whereArgs: whereArgs);
    return List.generate(
        mappedSenders.length, (i) => ApiMessageModel.fromMap(mappedSenders[i]));
  }

  Future<List<ApiMessageModel>> getAll() async {
    final List<Map<String, dynamic>> allMapped = await _database.query(_table);
    return List.generate(
        allMapped.length, (i) => ApiMessageModel.fromMap(allMapped[i]));
  }

  Future<ApiMessageModel> update(ApiMessageModel message) async {
    await _database.update(
      _table,
      message.toMap(),
      where: 'message_id = ?',
      whereArgs: [message.senderId],
    );
    return message;
  }

  Future<void> delete(int id) async {
    await _database.delete(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<ApiMessageModel>> getByParams(List<List<String?>> params) async {
    String where = '';
    List<String?> whereArgs = [];
    List<String?> whereParams = [];
    if (params.isNotEmpty) {
      params.forEach((param) {
        if (param[0] != null && param[1] != null) {
          whereParams.add(param[0]! + ' ' + param[1]! + ' ?');
          whereArgs.add(param[2] != null ? "${param[2].toString()}" : 'NULL');
        }
      });
      where = whereParams.join(' AND ');
    }
    final List<Map<String, Object?>> mappedSenders =
        await _database.query(_table, where: where, whereArgs: whereArgs);
    return List.generate(
        mappedSenders.length, (i) => ApiMessageModel.fromMap(mappedSenders[i]));
  }
}
