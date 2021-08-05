import 'package:app/src/slices/api_sender/model/api_sender_model.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class ApiSenderRepository {
  static const String _table = 'sender';
  final Database _database;

  ApiSenderRepository(this._database);

  Future<ApiSenderModel> insert(ApiSenderModel sender) async {
    int senderId = await _database.insert(_table, sender.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    sender.senderId = senderId;
    return sender;
  }

  Future<List<ApiSenderModel>> get(ApiSenderModel subject,
      {keepNull: false}) async {
    var subjectMap = subject.toMap();
    if (!keepNull) subjectMap.removeWhere((key, value) => value == null);
    String where = subjectMap.keys.join(' = ? AND ') + " = ?";
    List<String?> whereArgs = subjectMap.values
        .map((entry) => entry != null ? "'${entry.toString()}'" : 'NULL')
        .toList();
    final List<Map<String, Object?>> mappedSenders =
        await _database.query(_table, where: where, whereArgs: whereArgs);
    return List.generate(
        mappedSenders.length, (i) => ApiSenderModel.fromMap(mappedSenders[i]));
  }

  Future<List<ApiSenderModel>> getAll() async {
    final List<Map<String, dynamic>> allMapped = await _database.query(_table);
    return List.generate(
        allMapped.length, (i) => ApiSenderModel.fromMap(allMapped[i]));
  }

  Future<ApiSenderModel> update(ApiSenderModel sender) async {
    await _database.update(
      _table,
      sender.toMap(),
      where: 'sender_id = ?',
      whereArgs: [sender.senderId],
    );
    return sender;
  }

  Future<void> delete(int id) async {
    await _database.delete(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<ApiSenderModel>> getByParams(List<List<String?>> params) async {
    String where = '';
    List<String?> whereArgs = [];
    List<String?> whereParams = [];
    if (params.isNotEmpty) {
      params.forEach((param) {
        if (param[0] != null && param[1] != null) {
          whereParams.add(param[0]! + ' ' + param[1]! + ' ?');
          whereArgs.add(param[2] != null ? "${param[2]}" : 'NULL');
        }
      });
      where = whereParams.join(' AND ');
    }
    final List<Map<String, Object?>> mappedSenders =
        await _database.query(_table, where: where, whereArgs: whereArgs);
    return List.generate(
        mappedSenders.length, (i) => ApiSenderModel.fromMap(mappedSenders[i]));
  }

  Future<ApiSenderModel> getById(int id) async {
    final List<Map<String, Object?>> mappedCompanies =
        await _database.query(_table, where: "sender_id = ?", whereArgs: [id]);
    return List.generate(mappedCompanies.length,
        (i) => ApiSenderModel.fromMap(mappedCompanies[i])).first;
  }

  Future<ApiSenderModel?> getByEmail(String email) async {
    final List<Map<String, Object?>> mappedCompanies =
        await _database.query(_table, where: "email = ?", whereArgs: [email]);
    final sender = List.generate(mappedCompanies.length,
        (i) => ApiSenderModel.fromMap(mappedCompanies[i]));
    return sender.length == 0 ? null : sender.first;
  }
}
