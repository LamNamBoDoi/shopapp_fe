import 'dart:io';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopapp_v1/data/model/user.dart';
import 'package:shopapp_v1/data/repository/user_repo.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo repo;
  UserController({required this.repo});

  User _userCurrent = User();
  User get userCurrent => _userCurrent;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getCurrentUser() async {
    Response response = await repo.getDetailUser();
    if (response.statusCode == 200) {
      var responseData = response.body["payload"];
      if (responseData is Map<String, dynamic>) {
        _userCurrent = User.fromJson(responseData);
      }
    }
  }

  Future<int> updateUserInfo(User user, File? image) async {
    _isLoading = true;
    update();

    int result = 0;

    try {
      Response response = await repo.updateUserWithImage(user.id!, user, image);
      if (response.statusCode == 200) {
        var responseData = response.body["payload"];
        if (responseData is Map<String, dynamic>) {
          _userCurrent = User.fromJson(responseData);
        }
        result = 200;
      }
    } catch (e) {
      print("Update error: $e");
    } finally {
      _isLoading = false;
      update();
    }

    return result;
  }

  Future<void> clearUser() async {
    _userCurrent = User();
    update();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
