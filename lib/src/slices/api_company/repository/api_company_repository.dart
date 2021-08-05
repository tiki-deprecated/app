/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:sqflite_sqlcipher/sqlite_api.dart';

import '../model/api_company_model.dart';

class ApiCompanyRepository {
  static const String _table = 'company';
  final Database _database;

  ApiCompanyRepository(this._database);

  Future<ApiCompanyModel> insert(ApiCompanyModel company) async {
    int id = await _database.insert(_table, company.toMap());
    company.companyId = id;
    return company;
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

  Future<ApiCompanyModel?> getById(int id) async {
    final List<Map<String, Object?>> rows =
        await _database.query(_table, where: "company_id = ?", whereArgs: [id]);
    if (rows.isEmpty) return null;
    return ApiCompanyModel.fromMap(rows[0]);
  }

  Future<ApiCompanyModel?> getByDomain(String domain) async {
    final List<Map<String, Object?>> rows =
        await _database.query(_table, where: "domain = ?", whereArgs: [domain]);
    if (rows.isEmpty) return null;
    return ApiCompanyModel.fromMap(rows[0]);
  }
}
