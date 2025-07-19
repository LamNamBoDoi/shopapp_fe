import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp_v1/controller/category_controller.dart';
import 'package:shopapp_v1/controller/product_controller.dart';
import 'package:shopapp_v1/screen/home/widget/banner_sliver.dart';
import 'package:shopapp_v1/screen/home/widget/category_sliver.dart';
import 'package:shopapp_v1/screen/home/widget/custom_sliver_appbar.dart';
import 'package:shopapp_v1/screen/home/widget/product_sliver.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  RxInt selectedCategoryId = (-1).obs;
  final productCtl = Get.find<ProductController>();
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(0);
    });
    Get.find<CategoryController>().getListCategoryPage();
    productCtl.getListProductPage();
    productCtl.getProductIds();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          CustomSliverAppBar(searchController: searchController),
          BannerSliver(),
          CategorySliver(selectedCategoryId: selectedCategoryId),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "item".tr,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          ProductSliver()
        ],
      ),
    );
  }
}
