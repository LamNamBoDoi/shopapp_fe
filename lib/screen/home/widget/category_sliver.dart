import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp_v1/controller/category_controller.dart';
import 'package:shopapp_v1/controller/product_controller.dart';
import 'package:shopapp_v1/screen/home/widget/catogory_shimmer.dart';
import 'package:shopapp_v1/utils/app_constants.dart';
import 'package:shopapp_v1/utils/color_resource.dart';

class CategorySliver extends StatelessWidget {
  final RxInt selectedCategoryId;

  const CategorySliver({super.key, required this.selectedCategoryId});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GetBuilder<CategoryController>(
        builder: (ctl) {
          return Container(
            height: 160,
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Categories",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    Text("See all >",
                        style:
                            TextStyle(color: ColorResources.getTextColor1())),
                  ],
                ),
                SizedBox(height: 10),
                ctl.isLoading
                    ? const CategoryShimmer()
                    : Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: ctl.listCategories.length,
                          itemBuilder: (context, index) {
                            final category = ctl.listCategories[index];
                            return Obx(() {
                              final isSelected =
                                  selectedCategoryId.value == category.id;
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (isSelected) {
                                        selectedCategoryId.value = -1;
                                        Get.find<ProductController>()
                                            .getListProductPage();
                                        Get.find<ProductController>()
                                            .isSelectCate = false;
                                      } else {
                                        selectedCategoryId.value =
                                            category.id ?? -1;
                                        Get.find<ProductController>()
                                            .getListProductPage(
                                                categoryId: category.id);
                                        Get.find<ProductController>()
                                            .isSelectCate = true;
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      margin: const EdgeInsets.only(right: 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Colors.red
                                            : const Color(0xFFE6E9D4),
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 4,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: category.thumbnail?.isNotEmpty ==
                                                true
                                            ? Image.network(
                                                "${AppConstants.BASE_URL}${AppConstants.GET_IMAGES}/${category.thumbnail}",
                                                fit: BoxFit.cover,
                                                errorBuilder: (_, __, ___) =>
                                                    Icon(
                                                  Icons.image_not_supported,
                                                  color: Colors.grey.shade400,
                                                  size: 40,
                                                ),
                                              )
                                            : Image.network(
                                                "${AppConstants.BASE_URL}${AppConstants.GET_PRODUCT}/images/notfound.png",
                                                fit: BoxFit.cover,
                                                errorBuilder: (_, __, ___) =>
                                                    Icon(
                                                  Icons.image_not_supported,
                                                  color: Colors.grey.shade400,
                                                  size: 40,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    category.name ?? "No name",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              );
                            });
                          },
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
