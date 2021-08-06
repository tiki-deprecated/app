import 'package:app/src/slices/api_app_data/api_app_data_key.dart';
import 'package:app/src/slices/api_app_data/model/api_app_data_model.dart';
import 'package:app/src/slices/api_app_data/repository/api_app_data_repository.dart';
import 'package:sqflite_sqlcipher/sqlite_api.dart';

class ApiAppDataService {
  final ApiAppDataRepository _repository;

  ApiAppDataService({required Database database})
      : this._repository = ApiAppDataRepository(database);

  Future<ApiAppDataModel?> getByKey(ApiAppDataKey key) async =>
      key.value != null ? _repository.getByKey(key.value!) : null;

  Future<ApiAppDataModel?> save(ApiAppDataKey key, String value) async {
    if (key.value == null) return null;
    ApiAppDataModel? data = await this.getByKey(key);
    ApiAppDataModel dataToInsert =
        ApiAppDataModel(id: data?.id, key: key.value!, value: value);
    return data == null
        ? await _repository.insert(dataToInsert)
        : await _repository.update(dataToInsert);
  }
}
