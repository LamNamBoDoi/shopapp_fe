import 'dart:io';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shopapp_v1/data/api/api_client.dart';
import 'package:shopapp_v1/data/model/user.dart';
import 'package:shopapp_v1/utils/app_constants.dart';

class UserRepo {
  final ApiClient apiClient;
  UserRepo({required this.apiClient});

  Future<Response> getDetailUser() {
    return apiClient.getData(AppConstants.POST_DETAIL_USER);
  }

  Future<Response> updateUserWithImage(int userId, User user, File? image) {
    final Map<String, String> body = {
      'fullName': user.fullname ?? '',
      'phoneNumber': user.phoneNumber ?? '',
      'address': user.address ?? '',
      'password': user.password ?? '',
      'dateOfBirth': user.dob ?? '',
      'facebookAccountId': user.faceAccId?.toString() ?? '0',
      'googleAccountId': user.ggAccId?.toString() ?? '0',
    };

    return apiClient.postMultipartData(
      uri: "${AppConstants.POST_DETAIL_USER}/$userId",
      body: body,
      file: image,
    );
  }
}
