import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shopapp_v1/controller/product_controller.dart';
import 'package:shopapp_v1/controller/user_controller.dart';
import 'package:shopapp_v1/controller/wishlist_controller.dart';
import 'package:shopapp_v1/data/model/body/cart_item.dart';
import 'package:shopapp_v1/data/model/body/wishlist.dart';
import 'package:shopapp_v1/data/model/response/product_details.dart';
import 'package:shopapp_v1/screen/product_detail_screen/widget/product_description.dart';
import 'package:shopapp_v1/screen/product_detail_screen/widget/product_image_widget.dart';
import 'package:shopapp_v1/screen/product_detail_screen/widget/product_info_widget.dart';
import 'package:shopapp_v1/screen/product_detail_screen/widget/product_rating_widget.dart';
import 'package:shopapp_v1/screen/product_detail_screen/widget/product_review_widget.dart';
import 'package:shopapp_v1/utils/app_constants.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({required this.productDetails, super.key});
  final ProductDetails? productDetails;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final productCtl = Get.find<ProductController>();
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  final GlobalKey imageKey = GlobalKey();
  late Function(GlobalKey) runAddToCartAnimation;
  final wishlistCtl = Get.find<WishlistController>();
  final userCtl = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const kSectionDivider = Divider(
      height: 2,
      thickness: 2,
      color: Color.fromARGB(126, 245, 245, 245),
    );

    return AddToCartAnimation(
      dragAnimation: const DragToCartAnimationOptions(
        rotation: false,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 500),
      ),
      height: 20,
      width: 20,
      opacity: 0.85,
      cartKey: cartKey,
      createAddToCartAnimation: (runAddToCartAnimation) {
        this.runAddToCartAnimation = runAddToCartAnimation;
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(
            widget.productDetails?.name ?? "",
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: InkWell(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back),
          ),
          iconTheme: theme.appBarTheme.iconTheme,
          actions: [
            Obx(() => badges.Badge(
                  position: badges.BadgePosition.topEnd(top: 4, end: -4),
                  showBadge: productCtl.listCartItem.isNotEmpty,
                  badgeContent: Text(
                    productCtl.listCartItem.length.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  badgeStyle: const badges.BadgeStyle(
                    badgeColor: Colors.red,
                  ),
                  child: InkWell(
                    onTap: () async {
                      await Get.find<ProductController>().getProductIds();
                      Get.find<ProductController>().updateTotalMoney();
                      Get.back();
                      Get.find<PersistentTabController>().jumpToTab(1);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 3),
                      height: 50,
                      width: 30,
                      child: Icon(
                        key: cartKey,
                        Icons.shopping_cart_outlined,
                      ),
                    ),
                  ),
                )),
            Obx(
              () => IconButton(
                icon: wishlistCtl.listWishlist
                        .any((w) => w.productId == widget.productDetails?.id)
                    ? Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : Icon(
                        Icons.favorite_border,
                      ),
                onPressed: () {
                  if (wishlistCtl.listWishlist
                      .any((w) => w.productId == widget.productDetails?.id)) {
                    final existingWishlist = wishlistCtl.listWishlist
                        .where((w) => w.productId == widget.productDetails?.id)
                        .firstOrNull;
                    wishlistCtl.deleteWishlist(existingWishlist!).then((value) {
                      if (value == 200) {
                        wishlistCtl.getWishlistByUserId(userCtl.userCurrent);
                      }
                    });
                  } else {
                    wishlistCtl
                        .createWishlist(Wishlist(
                            userId: userCtl.userCurrent.id,
                            productId: widget.productDetails?.id))
                        .then((value) {
                      if (value == 200) {
                        wishlistCtl.getWishlistByUserId(userCtl.userCurrent);
                      }
                    });
                  }
                },
              ),
            )
          ],
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductImageWidget(
                          images: widget.productDetails?.productImages ?? [],
                        ),
                        ProductInfoWidget(
                            productDetails: widget.productDetails),
                        kSectionDivider,
                        ProductDescription(
                          description: widget.productDetails?.description,
                        ),
                        // kSectionDivider,
                        // _buildProductCategory(),
                        kSectionDivider,
                        ProductRatingWidget(
                            productDetails: widget.productDetails),
                        kSectionDivider,
                        ProductReviewWidget(
                            productDetails: widget.productDetails)
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60,
                      ),
                      Container(
                        key: imageKey,
                        child: widget.productDetails?.thumbnail == "" ||
                                widget.productDetails?.thumbnail == null
                            ? Image.network(
                                "${AppConstants.BASE_URL}${AppConstants.GET_PRODUCT}/images/notfound.png",
                                fit: BoxFit.cover,
                                width: 40,
                                height: 40,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  width: 40,
                                  height: 40,
                                  color: Colors.grey[200],
                                  child: const Icon(
                                    Icons.image_not_supported,
                                    size: 80,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            : Image.network(
                                "${AppConstants.BASE_URL}${AppConstants.GET_PRODUCT}/images/${widget.productDetails?.thumbnail}",
                                fit: BoxFit.cover,
                                width: 40,
                                height: 40,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  width: 40,
                                  height: 40,
                                  color: Colors.grey[200],
                                  child: const Icon(
                                    Icons.image_not_supported,
                                    size: 80,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              child: _buildActionBar(),
            )
          ],
        ),
      ),
    );
  }

  // Widget _buildProductCategory() {
  //   return Container(
  //     color: Colors.white,
  //     padding: const EdgeInsets.all(16.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         const Text(
  //           'Danh mục',
  //           style: TextStyle(
  //               fontSize: 18,
  //               fontWeight: FontWeight.w600,
  //               color: Colors.black87),
  //         ),
  //         const SizedBox(height: 8),
  //         Text(
  //           widget.productDetails?.category?.name ?? "Không xác định",
  //           style: const TextStyle(fontSize: 14, color: Colors.black54),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildActionBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () async {
                await runAddToCartAnimation(imageKey);
                int index = productCtl.listCartItem.indexWhere(
                  (item) => item.id == widget.productDetails?.id,
                );
                if (index != -1) {
                  productCtl.listCartItem[index].quantity += 1;
                } else {
                  productCtl.listCartItem.add(
                    CartItem(
                      id: widget.productDetails?.id ?? -1,
                      quantity: 1,
                    ),
                  );
                }
                await productCtl.saveStorage();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFFEE4D2D),
                side: const BorderSide(color: Color(0xFFEE4D2D)),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Thêm vào giỏ hàng',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () async {
                await Get.find<ProductController>().getProductIds();
                Get.find<ProductController>().updateTotalMoney();
                Get.back();
                Get.find<PersistentTabController>().jumpToTab(1);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEE4D2D),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Mua ngay',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
