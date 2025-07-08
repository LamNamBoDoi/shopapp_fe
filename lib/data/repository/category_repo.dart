import 'package:get/get.dart';
import 'package:shopapp_v1/data/api/api_client.dart';
import 'package:shopapp_v1/utils/app_constants.dart';

class CategoryRepo {
  final ApiClient apiClient;
  CategoryRepo({required this.apiClient});

  Future<Response> getListCategoryPage(
      String keyWord, int pageIndex, int limit, int status) async {
    return await apiClient.getData(
      AppConstants.GET_CATEGORY,
      query: {
        'page': pageIndex.toString(),
        'limit': limit.toString(),
        'keyWord': keyWord,
        'status': status.toString(),
      },
      headers: {},
    );
  }
}
