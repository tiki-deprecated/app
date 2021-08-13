/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:sqflite_sqlcipher/sqlite_api.dart';

import '../model/api_company_model_local.dart';

class ApiCompanyRepositoryLocal {
  static const String _table = 'company';
  final Database _database;

  ApiCompanyRepositoryLocal(this._database);

  Future<ApiCompanyModelLocal> insert(ApiCompanyModelLocal company) async {
    DateTime now = DateTime.now();
    company.modified = now;
    company.created = now;
    int id = await _database.insert(_table, company.toMap());
    company.companyId = id;
    return company;
  }

  Future<ApiCompanyModelLocal> update(ApiCompanyModelLocal company) async {
    company.modified = DateTime.now();
    await _database.update(
      _table,
      company.toMap(),
      where: 'company_id = ?',
      whereArgs: [company.companyId],
    );
    return company;
  }

  Future<ApiCompanyModelLocal?> getById(int id) async {
    final List<Map<String, Object?>> rows =
        await _database.query(_table, where: "company_id = ?", whereArgs: [id]);
    if (rows.isEmpty) return null;
    return ApiCompanyModelLocal.fromMap(rows[0]);
  }

  Future<ApiCompanyModelLocal?> getByDomain(String domain) async {
    final List<Map<String, Object?>> rows =
        await _database.query(_table, where: "domain = ?", whereArgs: [domain]);
    if (rows.isEmpty) return null;
    return ApiCompanyModelLocal.fromMap(rows[0]);
  }
}
