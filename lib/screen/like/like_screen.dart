import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp_v1/controller/product_controller.dart';
import 'package:shopapp_v1/controller/wishlist_controller.dart';
import 'package:shopapp_v1/data/model/body/product.dart';
import 'package:shopapp_v1/screen/like/widget/product_like_item.dart';

class LikeScreen extends StatelessWidget {
  const LikeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistCtl = Get.find<WishlistController>();
    final productCtl = Get.find<ProductController>();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Yêu thích',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
              fontSize: 22,
            ),
          ),
          centerTitle: true,
        ),
        body: Obx(() {
          if (wishlistCtl.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (wishlistCtl.listWishlist.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                  SizedBox(height: 12),
                  Text(
                    'Bạn chưa có sản phẩm yêu thích nào',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: wishlistCtl.listWishlist.length,
            itemBuilder: (context, index) {
              final wishlist = wishlistCtl.listWishlist[index];

              final product = productCtl.listProducts.firstWhere(
                (product) => product.id == wishlist.productId,
                orElse: () => Product(id: -1, name: 'Sản phẩm không tồn tại'),
              );

              if (product.id == -1) return const SizedBox.shrink();

              return ProductLikeItem(
                product: product,
                wishlist: wishlist,
              );
            },
          );
        }));
  }
}
