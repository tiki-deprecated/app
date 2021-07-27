import 'package:app/src/slices/api_app_data/model/api_app_data_model.dart';
import 'package:app/src/slices/api_app_data/repository/api_app_data_repository.dart';

class ApiAppDataService {
  Future<ApiAppDataModel?> getByKey(String key) async {
    return await ApiAppDataRepository().getByKey(key);
  }

  Future<ApiAppDataModel> save(String key, String value) async {
    var data = await this.getByKey(key);
    var dataToInsert = ApiAppDataModel(id: data?.id, key: key, value: value);
    return data == null
        ? await ApiAppDataRepository().insert(dataToInsert)
        : await ApiAppDataRepository().update(dataToInsert);
  }
}
