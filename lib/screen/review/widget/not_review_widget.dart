import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp_v1/data/model/body/product.dart';
import 'package:shopapp_v1/screen/review/review_product_screen.dart';
import 'package:shopapp_v1/utils/app_constants.dart';

class NotReviewWidget extends StatelessWidget {
  final VoidCallback? onReviewSuccess;
  const NotReviewWidget({
    super.key,
    required this.product,
    this.onReviewSuccess,
  });
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.thumbnail != ""
                    ? "${AppConstants.BASE_URL}${AppConstants.GET_PRODUCT}/images/${product.thumbnail}"
                    : "${AppConstants.BASE_URL}${AppConstants.GET_PRODUCT}/images/notfound.png",
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name ?? 'Không rõ',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () => Get.to(() => ReviewProductScreen(
                            product: product,
                            onReviewSuccess: onReviewSuccess,
                          )),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text("Đánh giá",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
