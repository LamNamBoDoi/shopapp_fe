import 'package:get/get.dart';
import 'package:shopapp_v1/data/model/user.dart';
import 'package:shopapp_v1/data/repository/auth_repo.dart';
import 'package:shopapp_v1/data/response/TokenResponse.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo repo;

  AuthController({required this.repo});

  bool _loading = false;
  User _user = User();

  bool get loading => _loading;
  User get user => _user;

  Future<int> login(String username, String password) async {
    _loading = true;
    update();
    Response response =
        await repo.login(username: username, password: password);
    print(response.body);
    if (response.statusCode == 200) {
      TokenResponse tokeBody = TokenResponse.fromJson(response.body);
      // repo.saveUserToken(tokeBody.accessToken!);
    } else {
      // ApiChecker.checkApi(response);
    }
    _loading = false;
    update();
    return response.statusCode!;
  }
}
