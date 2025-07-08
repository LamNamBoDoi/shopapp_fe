import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp_v1/controller/product_controller.dart';
import 'package:shopapp_v1/controller/review_controller.dart';
import 'package:shopapp_v1/screen/review/widget/not_review_widget.dart';

class TabProductNotreview extends StatefulWidget {
  const TabProductNotreview({super.key});

  @override
  State<TabProductNotreview> createState() => _TabProductNotreviewState();
}

class _TabProductNotreviewState extends State<TabProductNotreview> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (ctl) {
      if (ctl.isLoading) {
        return const Center(
          child: SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(strokeWidth: 3),
          ),
        );
      }
      List<int> reviewedProductIds = Get.find<ReviewController>()
          .listReview
          .map((review) => review.productId)
          .whereType<int>()
          .toList();
      final notReviews = ctl.listProductPurchased
          .where((product) => !reviewedProductIds.contains(product.id))
          .toList();
      if (notReviews.isEmpty) return _buildEmptyState();
      return RefreshIndicator(
        onRefresh: () async {
          // await ctl.refreshReviews();
        },
        child: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: notReviews.length,
          itemBuilder: (context, index) {
            final notReview = notReviews[index];
            return NotReviewWidget(
              product: notReview,
              onReviewSuccess: () {
                setState(() {});
              },
            );
          },
        ),
      );
    });
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.rate_review_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text("Chưa mua sản phẩm nào",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600])),
        ],
      ),
    );
  }
}
