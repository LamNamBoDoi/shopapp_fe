import 'dart:convert';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopapp_v1/data/api/api_client.dart';
import 'package:shopapp_v1/data/model/user.dart';
import 'package:shopapp_v1/data/token_request.dart';
import 'package:shopapp_v1/utils/app_constants.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> login(
      {required String username, required String password}) async {
    //header login
    // var token = "Basic Y29yZV9jbGllbnQ6c2VjcmV0";
    // var languageCode = sharedPreferences.getString(AppConstants.LANGUAGE_CODE);
    Map<String, String> _header = {
      'Content-Type': 'application/json',
      // AppConstants.LOCALIZATION_KEY:
      //     languageCode ?? AppConstants.languages[0].languageCode,
      // 'Authorization': '$token'
    };
    //call api login
    return await apiClient.postDataLogin(
        AppConstants.LOGIN,
        jsonEncode(TokenRequest(
          username: username,
          password: password,
        ).toJson()),
        _header);
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = "Bearer $token";
    apiClient.updateHeader("Bearer $token", null,
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? "vi", 0);
    return await sharedPreferences.setString(
        AppConstants.TOKEN, "Bearer $token");
  }

  Future<Response> signup(User user) async {
    Map<String, String> _header = {
      'Content-Type': 'application/json',
      // AppConstants.LOCALIZATION_KEY:
      //     languageCode ?? AppConstants.languages[0].languageCode,
      // 'Authorization': '$token'
    };
    return await apiClient.postData(
        AppConstants.REGISTER, jsonEncode(user), _header);
  }
}
