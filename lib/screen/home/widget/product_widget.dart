import 'package:flutter/material.dart';
import 'package:shopapp_v1/data/model/body/product.dart';
import 'package:shopapp_v1/utils/app_constants.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade100,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: product.thumbnail != ""
                    ? Image.network(
                        "${AppConstants.BASE_URL}${AppConstants.GET_PRODUCT}/images/${product.thumbnail!}",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.image_not_supported,
                            color: Colors.grey.shade400,
                            size: 40,
                          );
                        },
                      )
                    : Image.network(
                        "${AppConstants.BASE_URL}${AppConstants.GET_PRODUCT}/images/notfound.png",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.image_not_supported,
                            color: Colors.grey.shade400,
                            size: 40,
                          );
                        },
                      ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              product.name ?? 'No name',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(5, (index) {
                  final rating = product.averageRating?.toDouble() ?? 0.0;
                  if (index < rating.floor()) {
                    return Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 14,
                    );
                  } else if (index < rating) {
                    return Icon(
                      Icons.star_half,
                      color: Colors.amber,
                      size: 14,
                    );
                  } else {
                    return Icon(
                      Icons.star_border,
                      color: Colors.amber,
                      size: 14,
                    );
                  }
                }),
                const SizedBox(width: 4),
                Text(
                  '${product.averageRating ?? 0}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${product.price?.toStringAsFixed(0) ?? '0'} VNĐ',
                style: TextStyle(
                  color: Colors.green.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
