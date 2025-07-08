import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp_v1/controller/product_controller.dart';
import 'package:shopapp_v1/controller/review_controller.dart';
import 'package:shopapp_v1/controller/user_controller.dart';
import 'package:shopapp_v1/data/model/body/product.dart';
import 'package:shopapp_v1/data/model/body/review.dart';
import 'package:shopapp_v1/utils/app_constants.dart';
import 'package:shopapp_v1/view/custom_snackbar.dart';

class ReviewProductScreen extends StatefulWidget {
  final VoidCallback? onReviewSuccess;
  const ReviewProductScreen({
    super.key,
    required this.product,
    this.onReviewSuccess,
  });
  final Product product;
  @override
  State<ReviewProductScreen> createState() => _ReviewProductScreenState();
}

class _ReviewProductScreenState extends State<ReviewProductScreen> {
  RxInt rate = 0.obs;
  final commentCtl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Đánh giá sản phẩm",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white.withOpacity(0.9),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 55),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                              8), // điều chỉnh độ bo góc ở đây
                          child: Image.network(
                            widget.product.thumbnail != ""
                                ? "${AppConstants.BASE_URL}${AppConstants.GET_PRODUCT}/images/${widget.product.thumbnail}"
                                : "${AppConstants.BASE_URL}${AppConstants.GET_PRODUCT}/images/notfound.png",
                            width: 48, // hoặc kích thước bạn muốn
                            height: 48,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.product.name ?? 'Không rõ',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Đánh giá sản phẩm",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(5, (index) {
                                return GestureDetector(
                                  onTap: () => rate.value = index + 1,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    padding: const EdgeInsets.all(4),
                                    child: Icon(
                                      index < rate.value
                                          ? Icons.star_rounded
                                          : Icons.star_outline_rounded,
                                      color: index < rate.value
                                          ? Colors.amber[600]
                                          : Colors.grey[400],
                                      size: 40,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Nhận xét của bạn",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: commentCtl,
                            maxLines: 4,
                            decoration: InputDecoration(
                              hintText:
                                  "Chia sẻ trải nghiệm của bạn về sản phẩm này...",
                              hintStyle: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: Colors.grey[300]!),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: Colors.grey[300]!),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.grey[50],
                              contentPadding: const EdgeInsets.all(16),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => Get.find<ReviewController>()
                      .createReview(Review(
                          productId: widget.product.id,
                          userId: Get.find<UserController>().userCurrent.id,
                          rating: rate.value,
                          status: "APPROVED",
                          comment: commentCtl.text))
                      .then((value) {
                    if (value == 200) {
                      showCustomFlash("Đánh giá thành công", context,
                          isError: false);
                      Get.find<ReviewController>()
                          .getReviewByUserId(
                              Get.find<UserController>().userCurrent)
                          .then((_) {
                        widget.onReviewSuccess?.call();
                        Get.find<ProductController>().getListProductPage();
                        Get.back();
                      });
                    } else {
                      showCustomFlash("Đánh giá ko thành công", context,
                          isError: true);
                    }
                  }),
                  child: Container(
                    height: 45,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width - 20,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text("Gửi",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
