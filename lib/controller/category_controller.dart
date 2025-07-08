import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shopapp_v1/data/model/body/category_model.dart';
import 'package:shopapp_v1/data/model/pageable_response.dart';
import 'package:shopapp_v1/data/repository/category_repo.dart';

class CategoryController extends GetxController implements GetxService {
  final CategoryRepo repo;

  CategoryController({required this.repo});

  List<CategoryModel> _listCategories = [];
  List<CategoryModel> get listCategories => _listCategories;

  bool isLoading = false;

  Future<void> getListCategoryPage() async {
    isLoading = true;
    update();
    PageableResponse<CategoryModel>? pagedResponse =
        await _fetchCaregories(0, 10);

    if (pagedResponse != null) {
      _listCategories = pagedResponse.content;
    } else {
      // Xử lý lỗi nếu cần
      listCategories.clear();
    }

    isLoading = false;
    update();
  }

  Future<PageableResponse<CategoryModel>?> _fetchCaregories(
      int page, int size) async {
    Response response = await repo.getListCategoryPage("", page, size, 0);
    debugPrint(
        "Fetching users - Page: $page, Size: $size, Status: ${response.statusCode}");

    if (response.statusCode == 200) {
      var responseData = response.body;
      if (responseData is Map<String, dynamic>) {
        return PageableResponse<CategoryModel>.fromJson(
            responseData, (json) => CategoryModel.fromJson(json));
      } else {
        throw Exception("Unexpected response format");
      }
    } else {
      // ApiChecker.checkApi(response);
      return null;
    }
  }
}
