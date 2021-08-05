import 'package:app/src/slices/api_app_data/model/api_app_data_model.dart';
import 'package:app/src/slices/api_app_data/repository/api_app_data_repository.dart';
import 'package:sqflite_sqlcipher/sqlite_api.dart';

class ApiAppDataService {
  final ApiAppDataRepository _repository;

  ApiAppDataService({required Database database})
      : this._repository = ApiAppDataRepository(database);

  Future<ApiAppDataModel?> getByKey(String key) => _repository.getByKey(key);

  Future<ApiAppDataModel?> save(String key, String value) async {
    var data = await this.getByKey(key);
    var dataToInsert = ApiAppDataModel(id: data?.id, key: key, value: value);
    return data == null
        ? await _repository.insert(dataToInsert)
        : await _repository.update(dataToInsert);
  }
}
