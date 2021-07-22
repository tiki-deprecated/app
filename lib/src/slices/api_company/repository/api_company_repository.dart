import 'package:app/src/slices/api_company/model/api_company_model.dart';
import 'package:app/src/slices/api_sqlite/api_sqlite_service.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class ApiCompanyRepository {
  String _table = 'company';

  Future<ApiCompanyModel> insert(ApiCompanyModel company) async {
    final db = await ApiSqliteService().db;
    int senderId = await db.insert(_table, company.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    company.companyId = senderId;
    return company;
  }

  Future<List<ApiCompanyModel>> get(ApiCompanyModel subject) async {
    final db = await ApiSqliteService().db;
    var subjectMap = subject.toMap();
    String where = subjectMap.keys.join(' = ?,');
    List<String> whereArgs =
        subjectMap.entries.map((entry) => entry.toString()).toList();
    final List<Map<String, Object?>> mappedCompanies =
        await db.query(_table, where: where, whereArgs: whereArgs);
    return List.generate(mappedCompanies.length,
        (i) => ApiCompanyModel.fromMap(mappedCompanies[i]));
  }

  Future<List<ApiCompanyModel>> getAll() async {
    final db = await ApiSqliteService().db;
    final List<Map<String, dynamic>> allMapped = await db.query(_table);
    return List.generate(
        allMapped.length, (i) => ApiCompanyModel.fromMap(allMapped[i]));
  }

  Future<ApiCompanyModel> update(ApiCompanyModel company) async {
    final db = await ApiSqliteService().db;
    await db.update(
      _table,
      company.toMap(),
      where: 'sender_id = ?',
      whereArgs: [company.companyId],
    );
    return company;
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
