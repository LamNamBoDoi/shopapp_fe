import 'dart:convert';

import 'package:get/get.dart';
import 'package:shopapp_v1/data/api/api_client.dart';
import 'package:shopapp_v1/data/model/body/order.dart';
import 'package:shopapp_v1/utils/app_constants.dart';

class OrderRepo {
  final ApiClient apiClient;
  OrderRepo({required this.apiClient});

  Future<Response> createOrder({required Order order}) async {
    return await apiClient.postData(
        AppConstants.POST_ORDER, jsonEncode(order), null);
  }

  Future<Response> getListOrderByUserId({required int userId}) async {
    return await apiClient
        .getData(AppConstants.GET_ORDER_BY_USER_ID + userId.toString());
  }

  Future<Response> getListOrderById({required int orderId}) async {
    return await apiClient.getData("${AppConstants.GET_ORDER_DETAIL}/$orderId");
  }
}
