import 'package:app/src/slices/api_sqlite/repository/api_sqlite_repository.dart';

class ApiSqliteService {
  get db async => await ApiSqliteRepository.instance.database;
}
