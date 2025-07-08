import 'package:flutter/material.dart';
import 'package:shopapp_v1/data/model/body/review.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({required this.review, super.key});
  final Review? review;

  @override
  Widget build(BuildContext context) {
    final rating = (review?.rating ?? 0).toDouble();
    final comment = review?.comment ?? '';
    final userName = review?.userName ?? '';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, size: 18, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Text(
                userName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(5, (index) {
              if (index < rating.floor()) {
                return const Icon(Icons.star, color: Colors.amber, size: 16);
              } else if (index < rating) {
                return const Icon(Icons.star_half,
                    color: Colors.amber, size: 16);
              } else {
                return const Icon(Icons.star_border,
                    color: Colors.amber, size: 16);
              }
            }),
          ),
          const SizedBox(height: 8),
          Text(
            comment,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
