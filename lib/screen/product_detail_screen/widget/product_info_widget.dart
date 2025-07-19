import 'package:flutter/material.dart';
import 'package:shopapp_v1/data/model/response/product_details.dart';

class ProductInfoWidget extends StatelessWidget {
  const ProductInfoWidget({required this.productDetails, super.key});

  final ProductDetails? productDetails;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productDetails?.name ?? "",
            style: theme.appBarTheme.titleTextStyle,
          ),
          const SizedBox(height: 8),
          Text(
            '${productDetails?.price?.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}đ',
            style: const TextStyle(
              fontSize: 24,
              color: Color(0xFFEE4D2D),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
