import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp_v1/controller/localization_controller.dart';
import 'package:shopapp_v1/controller/theme_controller.dart';
import 'package:shopapp_v1/helper/route_helper.dart';
import 'package:shopapp_v1/theme/dark_theme.dart';
import 'package:shopapp_v1/theme/light_theme.dart';
import 'package:shopapp_v1/utils/app_constants.dart';
import 'package:shopapp_v1/utils/messages.dart';
import 'helper/get_di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Map<String, Map<String, String>> languages = await di.init();
  runApp(MyApp(
    languages: languages,
  ));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>>? languages;

  const MyApp({super.key, this.languages});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        return GetMaterialApp(
          title: AppConstants.APP_NAME,
          debugShowCheckedModeBanner: false,
          theme: themeController.darkTheme!
              ? themeController.darkColor == null
                  ? dark()
                  : dark(color: themeController.darkColor!)
              : themeController.lightColor == null
                  ? light()
                  : light(color: themeController.lightColor!),
          initialRoute: RouteHelper.signIn,
          getPages: RouteHelper.routes,
          locale: localizeController.locale,
          translations: Messages(languages: languages),
          fallbackLocale: Locale(AppConstants.languages[0].languageCode,
              AppConstants.languages[0].countryCode),
        );
      });
    });
  }
}
