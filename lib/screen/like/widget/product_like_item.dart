import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp_v1/controller/product_controller.dart';
import 'package:shopapp_v1/controller/user_controller.dart';
import 'package:shopapp_v1/controller/wishlist_controller.dart';
import 'package:shopapp_v1/data/model/body/product.dart';
import 'package:shopapp_v1/data/model/body/wishlist.dart';
import 'package:shopapp_v1/screen/product_detail_screen/product_detail_screen.dart';
import 'package:shopapp_v1/utils/app_constants.dart';
import 'package:shopapp_v1/view/custom_snackbar.dart';

class ProductLikeItem extends StatelessWidget {
  ProductLikeItem({
    required this.product,
    required this.wishlist,
    super.key,
  });

  final Product product;
  final Wishlist wishlist;
  final wishlistCtl = Get.find<WishlistController>();
  final userCtl = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final imageUrl = product.thumbnail != null && product.thumbnail!.isNotEmpty
        ? "${AppConstants.BASE_URL}${AppConstants.GET_PRODUCT}/images/${product.thumbnail!}"
        : "${AppConstants.BASE_URL}${AppConstants.GET_PRODUCT}/images/notfound.png";

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Get.find<ProductController>()
              .getDetailProduct(product.id!)
              .then((value) {
            Get.to(ProductDetailScreen(productDetails: value));
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      imageUrl,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 90,
                          height: 90,
                          color: Colors.grey.shade200,
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey.shade400,
                            size: 30,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name ?? 'Tên sản phẩm',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      if (product.averageRating != null &&
                          product.averageRating! > 0)
                        Row(
                          children: [
                            // Thay thế phần hiển thị sao này:
                            if (product.averageRating != null &&
                                product.averageRating! > 0)
                              Row(
                                children: [
                                  ...List.generate(5, (index) {
                                    final rating =
                                        product.averageRating?.toDouble() ??
                                            0.0;
                                    if (index < rating.floor()) {
                                      return Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 14,
                                      );
                                    } else if (index < rating) {
                                      return Icon(
                                        Icons.star_half,
                                        color: Colors.amber,
                                        size: 14,
                                      );
                                    } else {
                                      return Icon(
                                        Icons.star_border,
                                        color: Colors.amber,
                                        size: 14,
                                      );
                                    }
                                  }),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${product.averageRating}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.green.shade100,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          '${product.price?.toStringAsFixed(0) ?? '0'} VNĐ',
                          style: TextStyle(
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.red.shade400,
                      size: 22,
                    ),
                    onPressed: () {
                      _showDeleteConfirmation(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Xóa khỏi yêu thích',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          content: Text(
            'Bạn có chắc chắn muốn xóa "${product.name}" khỏi danh sách yêu thích?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Hủy',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                wishlistCtl.deleteWishlist(wishlist).then((value) {
                  if (value == 200) {
                    wishlistCtl.getWishlistByUserId(userCtl.userCurrent);
                    showCustomFlash('Xóa thành công', Get.context!,
                        isError: false);
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade400,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Xóa'),
            ),
          ],
        );
      },
    );
  }
}
