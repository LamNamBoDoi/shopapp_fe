import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopapp_v1/controller/auth_controller.dart';
import 'package:shopapp_v1/controller/category_controller.dart';
import 'package:shopapp_v1/controller/order_controller.dart';
import 'package:shopapp_v1/controller/product_controller.dart';
import 'package:shopapp_v1/controller/review_controller.dart';
import 'package:shopapp_v1/controller/theme_controller.dart';
import 'package:shopapp_v1/controller/user_controller.dart';
import 'package:shopapp_v1/controller/wishlist_controller.dart';
import 'package:shopapp_v1/data/api/api_client.dart';
import 'package:shopapp_v1/data/model/language_model.dart';
import 'package:shopapp_v1/data/repository/auth_repo.dart';
import 'package:shopapp_v1/data/repository/category_repo.dart';
import 'package:shopapp_v1/data/repository/order_repo.dart';
import 'package:shopapp_v1/data/repository/product_repo.dart';
import 'package:shopapp_v1/data/repository/review_repo.dart';
import 'package:shopapp_v1/data/repository/user_repo.dart';
import 'package:shopapp_v1/data/repository/wishlist_repo.dart';
import 'package:shopapp_v1/utils/app_constants.dart';

Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => CategoryRepo(apiClient: Get.find()));
  Get.lazyPut(() =>
      ProductRepo(sharedPreferences: sharedPreferences, apiClient: Get.find()));
  Get.lazyPut(() => OrderRepo(apiClient: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(() => WishlistRepo(apiClient: Get.find()));
  Get.lazyPut(() => ReviewRepo(apiClient: Get.find()));
  // Controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => AuthController(repo: Get.find()));
  Get.lazyPut(() => CategoryController(repo: Get.find()));
  Get.lazyPut(() => ProductController(repo: Get.find()));
  Get.lazyPut(() => OrderController(repo: Get.find()));
  Get.lazyPut(() => UserController(repo: Get.find()));
  Get.lazyPut(() => WishlistController(repo: Get.find()));
  Get.lazyPut(() => ReviewController(repo: Get.find()));
  Get.lazyPut(() => PersistentTabController(), fenix: true);
  Map<String, Map<String, String>> languages = {};
  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    Map<String, String> _json = Map();
    mappedJson.forEach((key, value) {
      _json[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        _json;
  }
  return languages;
}
