import 'package:app/src/slices/api_company/model/api_company_model.dart';
import 'package:sqflite_sqlcipher/sqlite_api.dart';

class ApiCompanyRepository {
  static const String _table = 'company';
  final Database _database;

  ApiCompanyRepository(this._database);

  Future<ApiCompanyModel> insert(ApiCompanyModel company) async {
    int senderId = await _database.insert(_table, company.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    company.companyId = senderId;
    return company;
  }

  Future<List<ApiCompanyModel>> get(ApiCompanyModel subject,
      {keepNull: false}) async {
    var subjectMap = subject.toMap();
    if (!keepNull) subjectMap.removeWhere((key, value) => value == null);
    String where = subjectMap.keys.join(' = ? AND ') + " = ?";
    List<String?> whereArgs = subjectMap.values
        .map((entry) => entry != null ? "'${entry.toString()}'" : 'NULL')
        .toList();
    final List<Map<String, Object?>> mappedCompanies =
        await _database.query(_table, where: where, whereArgs: whereArgs);
    return List.generate(mappedCompanies.length,
        (i) => ApiCompanyModel.fromMap(mappedCompanies[i]));
  }

  Future<List<ApiCompanyModel>> getAll() async {
    final List<Map<String, dynamic>> allMapped = await _database.query(_table);
    return List.generate(
        allMapped.length, (i) => ApiCompanyModel.fromMap(allMapped[i]));
  }

  Future<ApiCompanyModel> update(ApiCompanyModel company) async {
    await _database.update(
      _table,
      company.toMap(),
      where: 'company_id = ?',
      whereArgs: [company.companyId],
    );
    return company;
  }

  Future<void> delete(int id) async {
    await _database.delete(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<ApiCompanyModel> getById(int id) async {
    final List<Map<String, Object?>> mappedCompanies =
        await _database.query(_table, where: "company_id = ?", whereArgs: [id]);
    return List.generate(mappedCompanies.length,
        (i) => ApiCompanyModel.fromMap(mappedCompanies[i])).first;
  }

  Future<ApiCompanyModel?> getByDomain(String domain) async {
    final List<Map<String, Object?>> mappedCompanies =
        await _database.query(_table, where: "domain = ?", whereArgs: [domain]);
    final company = List.generate(mappedCompanies.length,
        (i) => ApiCompanyModel.fromMap(mappedCompanies[i]));
    return company.length == 0 ? null : company.first;
  }
}
