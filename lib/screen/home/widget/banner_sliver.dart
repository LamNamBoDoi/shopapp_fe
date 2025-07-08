import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shopapp_v1/utils/dimensions.dart';
import 'package:shopapp_v1/utils/images.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSliver extends StatelessWidget {
  BannerSliver({super.key});
  final List<String> banners = [
    Images.banner1,
    Images.banner1,
    Images.banner2,
    Images.banner2,
  ];
  RxInt bannerCurrentPosition = (-1).obs;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 135,
        margin: EdgeInsets.all(10),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              onPageChanged: (value) {
                bannerCurrentPosition.value = value;
              },
              children: banners.map((image) {
                return Image.asset(image, fit: BoxFit.cover);
              }).toList(),
            ),
            Positioned(
              bottom: 10,
              child: Obx(() {
                return AnimatedSmoothIndicator(
                  activeIndex: bannerCurrentPosition.value,
                  count: banners.length,
                  effect: const ExpandingDotsEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    activeDotColor: Color(0xFF85A802),
                    dotColor: Colors.white,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
