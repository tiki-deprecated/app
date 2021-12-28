/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:sqflite_sqlcipher/sqflite.dart';

import '../model/api_oauth_model_account.dart';

class ApiOAuthRepositoryAccount {
  static const String _table = 'auth_service_account';
  final Database _database;

  ApiOAuthRepositoryAccount(this._database);

  Future<ApiOAuthModelAccount> insert(ApiOAuthModelAccount account) async {
    DateTime now = DateTime.now();
    account.modified = now;
    account.created = now;
    int id = await _database.insert(_table, account.toJson());
    account.accountId = id;
    return account;
  }

  Future<ApiOAuthModelAccount> update(ApiOAuthModelAccount account) async {
    account.modified = DateTime.now();
    await _database.update(
      _table,
      account.toJson(),
      where: 'account_id = ?',
      whereArgs: [account.accountId],
    );
    return account;
  }

  Future<ApiOAuthModelAccount?> getById(int id) async {
    final List<Map<String, Object?>> rows =
        await _database.query(_table, where: "account_id = ?", whereArgs: [id]);
    if (rows.isEmpty) return null;
    return ApiOAuthModelAccount.fromJson(rows[0]);
  }

  Future<List<ApiOAuthModelAccount>> getByProvider(String provider) async {
    final List<Map<String, Object?>> rows = await _database
        .query(_table, where: "provider = ?", whereArgs: [provider]);
    if (rows.isEmpty) return [];
    return rows.map((e) => ApiOAuthModelAccount.fromJson(e)).toList();
  }

  Future<ApiOAuthModelAccount?> getByProviderAndUsername(
      String provider, String username) async {
    final List<Map<String, Object?>> rows = await _database.query(_table,
        where: "provider = ? AND username = ?",
        whereArgs: [provider, username]);
    if (rows.isEmpty) return null;
    return ApiOAuthModelAccount.fromJson(rows[0]);
  }

  Future<void> delete(ApiOAuthModelAccount apiAuthServiceAccountModel) async {
    await _database.delete(_table,
        where: "provider = ? AND username = ?",
        whereArgs: [
          apiAuthServiceAccountModel.provider,
          apiAuthServiceAccountModel.username
        ]);
  }

  Future<List<ApiOAuthModelAccount>> getAll() async {
    final List<Map<String, Object?>> rows = await _database.query(_table);
    if (rows.isEmpty) return [];
    return rows.map((e) => ApiOAuthModelAccount.fromJson(e)).toList();
  }

  Future<ApiOAuthModelAccount?> getSingleAccount() async {
    List<ApiOAuthModelAccount> accounts = await getAll();
    if (accounts.isEmpty) return null;
    return accounts.first;
  }
}
