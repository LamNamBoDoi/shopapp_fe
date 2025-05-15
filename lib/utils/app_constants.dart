import 'package:shopapp_v1/data/model/language_model.dart';
import 'package:shopapp_v1/utils/images.dart';

class AppConstants {
  static const String APP_NAME = 'Base';
  static const String APP_VERSION = "1.0.0";

  static const String BASE_URL = 'http://192.168.1.160:8080/api/v1';
  static const String LOGIN = '/users/login';
  static const String REGISTER = 'users/register';

  // Shared Key
  static const String THEME = 'theme';
  static const String TOKEN = 'token';
  static const String LANGUAGE_CODE = 'language_code';
  static const String LOCALIZATION_KEY = 'X-localization';
  static const String MODULE_ID = 'moduleId';
  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.vietnam,
        languageName: 'Việt Nam',
        countryCode: 'VN',
        languageCode: 'vi'),
    LanguageModel(
        imageUrl: Images.english,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
  ];
}
