import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shopapp_v1/data/model/body/cart_item.dart';
import 'package:shopapp_v1/data/model/pageable_response.dart';
import 'package:shopapp_v1/data/model/body/product.dart';
import 'package:shopapp_v1/data/model/response/product_details.dart';
import 'package:shopapp_v1/data/repository/product_repo.dart';

class ProductController extends GetxController implements GetxService {
  final ProductRepo repo;
  ProductController({required this.repo});
  List<Product> _listProducts = [];
  List<Product> _listProductsByCategory = [];
  List<Product> _listProductsByWord = [];
  // List<Product> _listProductsByCart = [];
  // List<Product> get listProductsByCart => _listProductsByCart;
  List<Product> get listProductsByCategory => _listProductsByCategory;
  List<Product> get listProductsByWord => _listProductsByWord;
  List<Product> get listProducts => _listProducts;
  final RxList<CartItem> _listCartItem = RxList<CartItem>([]);
  final RxDouble _totalMoney = 0.0.obs;
  RxDouble get totalMoney => _totalMoney;
  RxList<CartItem> get listCartItem => _listCartItem;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isLoadingDetails = false;
  bool get isLoadingDetails => _isLoadingDetails;
  List<Product> _listProductPurchased = [];
  List<Product> get listProductPurchased => _listProductPurchased;
  bool isSelectCate = false;

  Future<void> getListProductPage(
      {int? page, int? limit, String? keyword, int? categoryId}) async {
    _isLoading = true;
    update();

    PageableResponse<Product>? pagedResponse = await _fetchCaregories(
      page ?? 0,
      limit ?? 10,
      keyword ?? '',
      categoryId ?? 0,
    );

    if (pagedResponse != null) {
      if (categoryId == null &&
          keyword == null &&
          limit == null &&
          page == null) {
        _listProducts = pagedResponse.content;
      } else if (categoryId != null) {
        _listProductsByCategory = pagedResponse.content;
      } else if (keyword != null) {
        _listProductsByWord = pagedResponse.content;
      }
    } else {
      _listProductsByCategory.clear();
    }

    _isLoading = false;
    update();
  }

  Future<void> getListProductPurchased(int userId) async {
    _isLoading = true;
    update();

    Response response = await repo.getProductPurchased(userId);
    if (response.statusCode == 200) {
      var responseData = response.body['payload'];
      if (responseData is List) {
        _listProductPurchased = responseData
            .map<Product>((json) => Product.fromJson(json))
            .toList();
      } else {
        throw Exception("Unexpected response format");
      }
    } else {
      // ApiChecker.checkApi(response);
      throw Exception("Failed to load purchased products");
    }
    _isLoading = false;
    update();
  }

  Future<ProductDetails?> getDetailProduct(int productId) async {
    try {
      _isLoadingDetails = true;
      update();

      Response response = await repo.getDetailProduct(productId);

      if (response.statusCode == 200) {
        var responseData = response.body;
        if (responseData is Map<String, dynamic>) {
          return ProductDetails.fromJson(responseData);
        } else {
          throw Exception("Unexpected response format");
        }
      } else {
        throw Exception("Failed to load details product");
      }
    } catch (e) {
      rethrow;
    } finally {
      _isLoadingDetails = false;
      update();
    }
  }

  Future<PageableResponse<Product>?> _fetchCaregories(
      int page, int size, String keyword, int categoryId) async {
    _isLoading = true;
    update();

    try {
      Response response =
          await repo.getListProductPage(keyword, page, size, categoryId);
      debugPrint(
          "Fetching users - Page: $page, Size: $size, Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        var responseData = response.body;
        if (responseData is Map<String, dynamic>) {
          return PageableResponse<Product>.fromJson(
              responseData, (json) => Product.fromJson(json));
        } else {
          throw Exception("Unexpected response format");
        }
      } else {
        return null;
      }
    } finally {
      _isLoading = false;
      update();
    }
  }

  Future<void> saveStorage() async {
    return await repo.saveCart(_listCartItem);
  }

  Future<void> getProductIds() async {
    _isLoading = true;
    update();
    _listCartItem.assignAll(await repo.loadCart());
    _isLoading = false;
    update();
  }

  // Future<int> getProductByCart() async {
  //   if (_listCartItem.isNotEmpty) {
  //     Response response = await repo.getProductByCart(_listCartItem);
  //     if (response.statusCode == 200) {
  //       var responseData = response.body;
  //       if (responseData is List) {
  //         _listProductsByCart = responseData
  //             .map<Product>((json) => Product.fromJson(json))
  //             .toList();
  //         update();
  //         return response.hashCode;
  //       } else {
  //         throw Exception("Unexpected response format: Expected List");
  //       }
  //     } else {
  //       // ApiChecker.checkApi(response);
  //       return response.hashCode;
  //     }
  //   } else {
  //     return 0;
  //   }
  // }

  void updateTotalMoney() {
    double total = 0.0;
    var cartItemMap = {for (var item in _listCartItem) item.id: item};
    for (var product in _listProducts) {
      var cartItem = cartItemMap[product.id];
      if (cartItem != null) {
        total += cartItem.quantity * (product.price ?? 0);
      }
    }
    print("Giá trị total tính được: $total");
    _totalMoney.value = total;
  }

  void removeFromCart(int productId) {
    _listCartItem.removeWhere((item) => item.id == productId);
    update();
    saveStorage();
    updateTotalMoney();
  }

  void clearCart() {
    _listCartItem.clear();
    saveStorage();
    updateTotalMoney();
    update();
  }
}
