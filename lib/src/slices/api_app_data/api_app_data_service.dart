import 'package:sqflite_sqlcipher/sqlite_api.dart';

import 'api_app_data_key.dart';
import 'model/api_app_data_model.dart';
import 'repository/api_app_data_repository.dart';

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

  Future<void> logout() async {
    List<ApiAppDataKey> keysToDelete = [
      ApiAppDataKey.userReferCode,
      ApiAppDataKey.gmailLastFetch,
      ApiAppDataKey.gmailLastPage,
      ApiAppDataKey.googleOauthModalComplete,
    ];
    keysToDelete.forEach((key) async {
      await _repository.deleteByKey(key);
    });
  }
}
