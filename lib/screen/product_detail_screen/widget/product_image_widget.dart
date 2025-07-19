import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp_v1/utils/app_constants.dart';
import 'package:shopapp_v1/data/model/body/image_model.dart';

class ProductImageWidget extends StatelessWidget {
  ProductImageWidget({required this.images, super.key});
  final List<ImageModel> images;
  final RxInt _currentImageIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: 350,
              viewportFraction: 1.0,
              enableInfiniteScroll: images.length > 1,
              onPageChanged: (index, reason) =>
                  _currentImageIndex.value = index),
          items: images.isNotEmpty
              ? images.map((image) {
                  return Image.network(
                    "${AppConstants.BASE_URL}${AppConstants.GET_PRODUCT}/images/${image.imageUrl}",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 350,
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 100,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }).toList()
              : [
                  Image.network(
                    "${AppConstants.BASE_URL}${AppConstants.GET_PRODUCT}/images/notfound.png",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 350,
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 100,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
        ),
        if (images.length > 1)
          Obx(() {
            return Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: images.asMap().entries.map((entry) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentImageIndex.value == entry.key
                          ? const Color(0xFFEE4D2D)
                          : Colors.grey.withOpacity(0.5),
                    ),
                  );
                }).toList(),
              ),
            );
          })
      ],
    );
  }
}
