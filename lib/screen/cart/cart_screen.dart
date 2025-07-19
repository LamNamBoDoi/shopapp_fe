import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp_v1/controller/product_controller.dart';
import 'package:shopapp_v1/data/model/body/product.dart';
import 'package:shopapp_v1/screen/cart/payment_screen.dart';
import 'package:shopapp_v1/screen/cart/widget/cart_item_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final productCtl = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'my_cart'.tr,
          style: theme.appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
      ),
      body: GetBuilder<ProductController>(
        builder: (ctl) {
          if (ctl.listCartItem.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "Giỏ hàng trống",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          return ctl.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      color: theme.colorScheme.onSurface.withOpacity(0.2),
                      child: Row(
                        children: [
                          Checkbox(
                            value: false,
                            onChanged: (value) {},
                            activeColor: Colors.orange,
                          ),
                          const Text(
                            "Chọn tất cả",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Obx(() {
                        return ListView.builder(
                          itemCount: ctl.listCartItem.length,
                          itemBuilder: (context, index) {
                            Product? product;
                            try {
                              product = ctl.listProducts.firstWhere(
                                (product) =>
                                    product.id == ctl.listCartItem[index].id,
                              );
                            } catch (e) {
                              product = null;
                            }
                            if (product == null) {
                              return SizedBox();
                            }
                            return CartItemWidget(
                              product: product,
                              index: index,
                              controller: ctl,
                            );
                          },
                        );
                      }),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onSurface.withOpacity(0.2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, -2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tổng thanh toán",
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                              Obx(() {
                                return Text(
                                  "${productCtl.totalMoney.value}₫",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              })
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () => Get.to(() => PaymentScreen()),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "Thanh toán",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
