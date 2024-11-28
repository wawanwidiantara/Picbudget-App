import 'package:get/get.dart';

import '../models/ner_result_model.dart';

class NerResultProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return NerResult.fromJson(map);
      if (map is List) {
        return map.map((item) => NerResult.fromJson(item)).toList();
      }
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<NerResult?> getNerResult(int id) async {
    final response = await get('nerresult/$id');
    return response.body;
  }

  Future<Response<NerResult>> postNerResult(NerResult nerresult) async =>
      await post('nerresult', nerresult);
  Future<Response> deleteNerResult(int id) async =>
      await delete('nerresult/$id');
}
