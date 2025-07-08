import 'dart:convert';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopapp_v1/data/api/api_client.dart';
import 'package:shopapp_v1/data/model/body/cart_item.dart';
import 'package:shopapp_v1/utils/app_constants.dart';

class ProductRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  ProductRepo({required this.sharedPreferences, required this.apiClient});

  Future<Response> getListProductPage(
      String keyWord, int pageIndex, int limit, int categoryId) async {
    return await apiClient.getData(AppConstants.GET_PRODUCT, query: {
      'page': pageIndex.toString(),
      'limit': limit.toString(),
      'keyword': keyWord,
      'category_id': categoryId.toString(),
    }, headers: {
      'Content-Type': 'application/json',
    });
  }

  Future<Response> getDetailProduct(int productId) async {
    return await apiClient.getData(AppConstants.GET_PRODUCT_DETAILS,
        query: {'id': productId.toString()});
  }

  // sản phẩm đã mua
  Future<Response> getProductPurchased(int userId) async {
    return await apiClient
        .getData(AppConstants.GET_PRODUCTS_PURCHASED + userId.toString());
  }

  Future<List<CartItem>> loadCart() async {
    final cartJson = sharedPreferences.getString('cart');
    if (cartJson != null) {
      final cartList = jsonDecode(cartJson) as List;
      return cartList
          .map((item) => CartItem.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    } else {
      return [];
    }
  }

  Future<void> saveCart(List<CartItem> cart) async {
    final cartJson = jsonEncode(cart.map((item) => item.toJson()).toList());
    await sharedPreferences.setString('cart', cartJson);
  }

  Future<Response> getProductByCart(List<CartItem> listCart) async {
    List<int> listId = listCart.map((e) => e.id).toList();
    final String idsParam = listId.join(',');
    return await apiClient
        .getData(AppConstants.GET_PRODUCT_BY_IDS, query: {'ids': idsParam});
  }
}
