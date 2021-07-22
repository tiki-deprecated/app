import 'package:app/src/slices/api_sqlite/repository/api_sqlite_repository.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class ApiSqliteService {
  static Future<Database> get db async =>
      await ApiSqliteRepository.instance.database;
}
