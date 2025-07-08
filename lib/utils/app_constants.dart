import 'package:shopapp_v1/data/model/language_model.dart';
import 'package:shopapp_v1/utils/images.dart';

class AppConstants {
  static const String APP_NAME = 'Base';
  static const String APP_VERSION = "1.0.0";

  static const String BASE_URL = 'http://192.168.1.160:8080/api/v1';
  static const String LOGIN = '/users/login';
  static const String REGISTER = '/users/register';
  static const String GET_CATEGORY = '/categories';
  static const String GET_IMAGES = '/images';
  static const String GET_PRODUCT = '/products';
  static const String GET_PRODUCT_DETAILS = '/products/details';
  static const String GET_PRODUCTS_PURCHASED = '/order_details/users/';
  static const String GET_PRODUCT_BY_IDS = '/products/by-ids';
  static const String GET_ORDER_BY_USER_ID = '/orders/user/';
  static const String GET_WISHLIST = '/wishlists/';
  static const String GET_WISHLIST_BY_USER_ID = '/wishlists/user/';
  static const String GET_REVIEW_BY_USER_ID = '/reviews/user/';
  static const String POST_ORDER = '/orders';
  static const String GET_ORDER_DETAIL = '/order_details/order';
  static const String POST_DETAIL_USER = '/users/details';
  static const String POST_WISHLIST = '/wishlists';
  static const String POST_REVIEW = '/reviews';

  // Shared Key
  static const String THEME = 'theme';
  static const String TOKEN = 'token';
  static const String PRODUCT_CART = 'product_cart';
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
