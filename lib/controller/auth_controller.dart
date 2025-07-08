import 'package:get/get.dart';
import 'package:shopapp_v1/controller/user_controller.dart';
import 'package:shopapp_v1/data/model/user.dart';
import 'package:shopapp_v1/data/repository/auth_repo.dart';
import 'package:shopapp_v1/data/response/TokenResponse.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo repo;

  AuthController({required this.repo});

  bool _loading = false;

  bool get loading => _loading;

  Future<int> login(String username, String password) async {
    _loading = true;
    update();

    try {
      Response response =
          await repo.login(username: username, password: password);

      if (response.statusCode == 200) {
        final tokenResponse = TokenResponse.fromJson(response.body['payload']);
        await repo.saveUserToken(tokenResponse.token ?? "");
      } else {
        // Bạn có thể xử lý lỗi cụ thể hơn ở đây nếu muốn
        print("Login failed: ${response.statusText}");
      }

      return response.statusCode!;
    } catch (e) {
      print("Exception during login: $e");
      return -1;
    } finally {
      _loading = false;
      update();
    }
  }

  Future<int> signUp(User user) async {
    _loading = true;
    update();

    try {
      Response response = await repo.signup(user);

      return response.statusCode!;
    } catch (e) {
      print("Exception during sign up: $e");
      return -1;
    } finally {
      _loading = false;
      update();
    }
  }
}
