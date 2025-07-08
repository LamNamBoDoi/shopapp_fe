import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp_v1/controller/product_controller.dart';
import 'package:shopapp_v1/controller/review_controller.dart';
import 'package:shopapp_v1/controller/user_controller.dart';
import 'review_widget.dart'; // import widget mới tách

class TabProductReviewed extends StatelessWidget {
  const TabProductReviewed({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReviewController>(
      builder: (ctl) {
        final reviews = ctl.listReview;

        if (reviews.isEmpty) return _buildEmptyState();

        return RefreshIndicator(
          onRefresh: () async {
            Get.find<ReviewController>()
                .getReviewByUserId(Get.find<UserController>().userCurrent);
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              final review = reviews[index];
              final product =
                  Get.find<ProductController>().listProducts.firstWhere(
                        (p) => p.id == review.productId,
                      );

              return ReviewWidget(review: review, product: product);
            },
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.rate_review_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text("Chưa có đánh giá nào",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600])),
          const SizedBox(height: 8),
          Text("Hãy là người đầu tiên đánh giá sản phẩm này",
              style: TextStyle(fontSize: 14, color: Colors.grey[500])),
        ],
      ),
    );
  }
}
