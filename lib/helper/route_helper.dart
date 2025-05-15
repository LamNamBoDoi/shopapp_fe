import 'package:get/get.dart';
import 'package:shopapp_v1/screen/sign_in/sign_in_screen.dart';

class RouteHelper {
  static const String initial = '/';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String home = '/home';

  static String getInitialRoute() => initial;

  static String getSignInRoute() => signIn;

  static String getSignUpRoute() => signUp;

  static List<GetPage> routes = [
    GetPage(name: signIn, page: () => SignInScreen()),
  ];
}
