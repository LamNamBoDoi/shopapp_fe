import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp_v1/controller/product_controller.dart';
import 'package:shopapp_v1/data/model/body/product.dart';
import 'package:shopapp_v1/screen/home/widget/product_shimmer.dart';
import 'package:shopapp_v1/screen/home/widget/product_widget.dart';
import 'package:shopapp_v1/screen/product_detail_screen/product_detail_screen.dart';

class ProductSliver extends StatelessWidget {
  const ProductSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (ctl) {
        List<Product> listProducts;
        if (ctl.isLoading) {
          return const ProductShimmer();
        }
        if (ctl.isSelectCate) {
          listProducts = ctl.listProductsByCategory;
        } else {
          listProducts = ctl.listProducts;
        }

        return SliverPadding(
          padding: const EdgeInsets.all(10),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final product = listProducts[index];
                return InkWell(
                  onTap: () {
                    ctl.getDetailProduct(product.id ?? 0).then((value) =>
                        Get.to(
                            () => ProductDetailScreen(productDetails: value)));
                  },
                  child: ProductWidget(product: product),
                );
              },
              childCount: listProducts.length,
            ),
          ),
        );
      },
    );
  }
}
