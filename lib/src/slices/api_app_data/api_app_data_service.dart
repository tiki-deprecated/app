import 'package:sqflite_sqlcipher/sqlite_api.dart';

import 'api_app_data_key.dart';
import 'model/api_app_data_model.dart';
import 'repository/api_app_data_repository.dart';

class ApiAppDataService {
  final ApiAppDataRepository _repository;

  ApiAppDataService({required Database database})
      : _repository = ApiAppDataRepository(database);

  Future<ApiAppDataModel?> getByKey(ApiAppDataKey key) async =>
      key.value != null ? _repository.getByKey(key.value!) : null;

  Future<String?> getByStringKey(String key) async =>
      (await _repository.getByKey(key))?.value;

  Future<String?> saveByStringKey(String key, String value) async {
    ApiAppDataModel? data = await _repository.getByKey(key);
    ApiAppDataModel dataToInsert = ApiAppDataModel(id: data?.id, key: key, value: value);
    return data == null
        ? (await _repository.insert(dataToInsert))?.value
        : (await _repository.update(dataToInsert)).value;
  }

  Future<ApiAppDataModel?> save(ApiAppDataKey key, String value) async {
    if (key.value == null) return null;
    ApiAppDataModel? data = await getByKey(key);
    ApiAppDataModel dataToInsert =
        ApiAppDataModel(id: data?.id, key: key.value!, value: value);
    return data == null
        ? await _repository.insert(dataToInsert)
        : await _repository.update(dataToInsert);
  }

  Future<void> delete(ApiAppDataKey key) async {
    ApiAppDataModel? data = await getByKey(key);
    if (data != null) await _repository.delete(data.id!);
  }

  Future<void> deleteUserData() async {
    List<ApiAppDataKey> keysToDelete = [
      ApiAppDataKey.userReferCode,
      ApiAppDataKey.testCardsDone,
      ApiAppDataKey.decisionOverlayShown,
    ];
    for (var key in keysToDelete) {
      await _repository.deleteByKey(key.value!);
    }
  }

  Future<void> deleteAllData() async {
    for (var key in ApiAppDataKey.values) {
      await _repository.deleteByKey(key.value!);
    }
  }
}
