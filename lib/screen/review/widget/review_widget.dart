import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shopapp_v1/controller/user_controller.dart';
import 'package:shopapp_v1/data/model/body/product.dart';
import 'package:shopapp_v1/data/model/body/review.dart';
import 'package:shopapp_v1/utils/app_constants.dart';

class ReviewWidget extends StatelessWidget {
  final Review review;
  final Product product;

  ReviewWidget({super.key, required this.review, required this.product});
  final user = Get.find<UserController>().userCurrent;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  // : null,
                  backgroundColor: Colors.grey,
                  // backgroundImage: user.avatarUrl != null
                  //     ? NetworkImage(user.avatarUrl!)
                  //     : null,
                  child:
                      // user.avatarUrl == null ?
                      Icon(Icons.person,
                          size: 18,
                          color: Colors.white), // màu nền khi chưa có ảnh
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.fullname ?? "Người dùng",
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    _buildStarRating(review.rating ?? 0),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  height: 50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            8), // điều chỉnh độ bo góc ở đây
                        child: Image.network(
                          product.thumbnail != ""
                              ? "${AppConstants.BASE_URL}${AppConstants.GET_PRODUCT}/images/${product.thumbnail}"
                              : "${AppConstants.BASE_URL}${AppConstants.GET_PRODUCT}/images/notfound.png",
                          width: 48, // hoặc kích thước bạn muốn
                          height: 48,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${product.name ?? 'Không rõ'}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),

            const SizedBox(height: 12),

            // Comment
            if (review.comment != null && review.comment!.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Text(
                  review.comment ?? "",
                  style: const TextStyle(
                      fontSize: 14, height: 1.4, color: Colors.black87),
                ),
              ),

            const SizedBox(height: 12),

            // Footer
            Row(
              children: [
                Icon(Icons.access_time, size: 14, color: Colors.grey[500]),
                const SizedBox(width: 4),
                Text(_formatDate(review.createdAt),
                    style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.thumb_up_outlined,
                            size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text("Hữu ích",
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[600])),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStarRating(int rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          size: 16,
          color: index < rating ? Colors.amber : Colors.grey[400],
        );
      }),
    );
  }

  String _formatDate(DateTime? createdAt) {
    if (createdAt != null) {
      return DateFormat('dd/MM/yyyy HH:mm').format(createdAt);
    }
    return "Vừa xong";
  }
}
