import 'package:flutter/material.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({required this.description, super.key});
  final String? description;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Mô tả sản phẩm',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87),
          ),
          const SizedBox(height: 8),
          Text(
            description ?? "Không có mô tả",
            style: const TextStyle(
                fontSize: 14, color: Colors.black54, height: 1.5),
          ),
        ],
      ),
    );
  }
}
