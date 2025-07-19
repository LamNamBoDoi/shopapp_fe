import 'package:flutter/material.dart';
import 'package:shopapp_v1/data/model/response/product_details.dart';

class ProductRatingWidget extends StatelessWidget {
  const ProductRatingWidget({required this.productDetails, super.key});
  final ProductDetails? productDetails;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "${productDetails?.averageRating}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(width: 4),
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Colors.amber, Colors.orange],
                ).createShader(bounds),
                child: Icon(
                  Icons.star,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 4),
              Text('Đánh Giá Sản Phẩm ',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              Text("(${productDetails?.reviews?.length})"),
              const Spacer(),
              Text(
                'Tất cả',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              Icon(
                Icons.chevron_right,
                size: 20,
                color: Colors.black54,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
