import 'dart:convert';

import 'package:get/get.dart';
import 'package:shopapp_v1/data/api/api_client.dart';
import 'package:shopapp_v1/data/model/body/wishlist.dart';
import 'package:shopapp_v1/data/model/user.dart';
import 'package:shopapp_v1/utils/app_constants.dart';

class WishlistRepo {
  final ApiClient apiClient;
  WishlistRepo({required this.apiClient});

  Future<Response> createWishlist({required Wishlist wishlist}) async {
    return await apiClient.postData(
        AppConstants.POST_WISHLIST,
        jsonEncode(
            {"user_id": wishlist.userId, "product_id": wishlist.productId}),
        null);
  }

  Future<Response> deleteWishlist({required Wishlist wishlist}) async {
    return await apiClient
        .deleteData(AppConstants.GET_WISHLIST + wishlist.id.toString());
  }

  Future<Response> getWishlistByUserId({required User user}) async {
    return await apiClient
        .getData(AppConstants.GET_WISHLIST_BY_USER_ID + user.id.toString());
  }
}
