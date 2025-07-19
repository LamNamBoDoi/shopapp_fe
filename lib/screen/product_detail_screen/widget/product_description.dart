import 'package:flutter/material.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({required this.description, super.key});
  final String? description;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mô tả sản phẩm',
            style: theme.appBarTheme.titleTextStyle,
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
