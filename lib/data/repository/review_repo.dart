import 'dart:convert';

import 'package:get/get.dart';
import 'package:shopapp_v1/data/api/api_client.dart';
import 'package:shopapp_v1/data/model/body/review.dart';
import 'package:shopapp_v1/data/model/user.dart';
import 'package:shopapp_v1/utils/app_constants.dart';

class ReviewRepo {
  final ApiClient apiClient;
  ReviewRepo({required this.apiClient});

  Future<Response> createReview({required Review review}) async {
    return await apiClient.postData(
        AppConstants.POST_REVIEW, jsonEncode(review.toJson()), null);
  }

  Future<Response> getReviewByUserId({required User user}) async {
    return await apiClient
        .getData(AppConstants.GET_REVIEW_BY_USER_ID + user.id.toString());
  }
}
