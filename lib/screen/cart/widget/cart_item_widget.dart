import 'package:flutter/material.dart';
import 'package:shopapp_v1/controller/product_controller.dart';
import 'package:shopapp_v1/data/model/body/product.dart';
import 'package:shopapp_v1/utils/app_constants.dart';

class CartItemWidget extends StatelessWidget {
  final Product product;
  final int index;
  final ProductController controller;

  const CartItemWidget({
    required this.product,
    required this.index,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: false,
              onChanged: (value) {},
              activeColor: Colors.orange,
            ),
            _buildThumbnail(),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name ?? '',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${product.price?.toStringAsFixed(0)}₫",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline, size: 20),
                        onPressed: () {
                          if (controller.listCartItem[index].quantity > 1) {
                            controller.listCartItem[index].quantity--;
                            controller.updateTotalMoney();
                            controller.saveStorage();
                            controller.listCartItem.refresh();
                          }
                        },
                      ),
                      (index == -1 || index >= controller.listCartItem.length)
                          ? Text("0")
                          : Text("${controller.listCartItem[index].quantity}"),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline, size: 20),
                        onPressed: index != -1
                            ? () {
                                controller.listCartItem[index].quantity++;
                                controller.updateTotalMoney();
                                controller.saveStorage();

                                controller.listCartItem.refresh();
                              }
                            : null,
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.delete,
                            color: Colors.red, size: 20),
                        onPressed: index != -1
                            ? () {
                                controller.removeFromCart(product.id ?? 0);
                              }
                            : null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: product.thumbnail == "" || product.thumbnail == null
          ? Container(
              width: 60,
              height: 60,
              color: Colors.grey[200],
              child: const Icon(
                Icons.image_not_supported,
                size: 60,
                color: Colors.grey,
              ),
            )
          : Image.network(
              "${AppConstants.BASE_URL}${AppConstants.GET_PRODUCT}/images/${product.thumbnail}",
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 60,
                height: 60,
                color: Colors.grey[200],
                child: const Icon(
                  Icons.image_not_supported,
                  size: 60,
                  color: Colors.grey,
                ),
              ),
            ),
    );
  }
}
