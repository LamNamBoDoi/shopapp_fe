import 'package:flutter/material.dart';
import 'package:shopapp_v1/data/model/response/product_details.dart';
import 'package:shopapp_v1/screen/product_detail_screen/widget/all_review_widget.dart';
import 'package:shopapp_v1/screen/product_detail_screen/widget/review_item.dart';

class ProductReviewWidget extends StatelessWidget {
  const ProductReviewWidget({required this.productDetails, super.key});
  final ProductDetails? productDetails;

  @override
  Widget build(BuildContext context) {
    final reviews = productDetails?.reviews ?? [];
    const maxReviewsToShow = 2;

    final isLongList = reviews.length > maxReviewsToShow;
    final reviewsToShow =
        isLongList ? reviews.take(maxReviewsToShow).toList() : reviews;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Đánh giá",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          if (reviews.isEmpty)
            const Text("Chưa có đánh giá nào.")
          else
            ...reviewsToShow.map((review) => ReviewItem(review: review)),
          if (isLongList)
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AllReviewsScreen(reviews: reviews),
                  ),
                );
              },
              child: Center(child: const Text("Xem tất cả đánh giá")),
            )
        ],
      ),
    );
  }
}
