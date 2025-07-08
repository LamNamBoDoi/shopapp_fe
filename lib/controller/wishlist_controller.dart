import 'package:get/get.dart';
import 'package:shopapp_v1/data/model/body/wishlist.dart';
import 'package:shopapp_v1/data/model/user.dart';
import 'package:shopapp_v1/data/repository/wishlist_repo.dart';

class WishlistController extends GetxController {
  final WishlistRepo repo;
  WishlistController({required this.repo});

  final RxList<Wishlist> _listWishlist = <Wishlist>[].obs;
  RxList<Wishlist> get listWishlist => _listWishlist;

  final RxBool isLoading = false.obs;

  Future<int?> createWishlist(Wishlist wishlist) async {
    Response response = await repo.createWishlist(wishlist: wishlist);
    return response.statusCode;
  }

  Future<int?> deleteWishlist(Wishlist wishlist) async {
    Response response = await repo.deleteWishlist(wishlist: wishlist);
    return response.statusCode;
  }

  Future<void> getWishlistByUserId(User user) async {
    isLoading.value = true;
    try {
      Response response = await repo.getWishlistByUserId(user: user);
      if (response.statusCode == 200) {
        var responseData = response.body["payload"];
        if (responseData is List) {
          _listWishlist.value = responseData
              .map<Wishlist>((json) => Wishlist.fromJson(json))
              .toList();
        } else {
          throw Exception("Unexpected response format");
        }
      } else {
        // Optional: handle error
      }
    } finally {
      isLoading.value = false;
    }
  }
}
