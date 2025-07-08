import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp_v1/controller/product_controller.dart';
import 'package:shopapp_v1/controller/review_controller.dart';
import 'package:shopapp_v1/controller/user_controller.dart';
import 'package:shopapp_v1/screen/review/widget/tab_not_review.dart';
import 'package:shopapp_v1/screen/review/widget/tab_reviewed.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = Get.find<UserController>().userCurrent;
      Get.find<ReviewController>().getReviewByUserId(user);
      Get.find<ProductController>().getListProductPurchased(user.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Đánh giá của tôi',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w400,
              fontSize: 22,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          bottom: const TabBar(
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.black54,
            indicatorColor: Colors.orange,
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            tabs: [
              Tab(text: 'Chưa đánh giá'),
              Tab(text: 'Đã đánh giá'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TabProductNotreview(),
            TabProductReviewed(),
          ],
        ),
      ),
    );
  }
}
