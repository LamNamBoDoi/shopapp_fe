import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shopapp_v1/controller/product_controller.dart';
import 'package:shopapp_v1/screen/cart/cart_screen.dart';
import 'package:shopapp_v1/screen/chat/chat_screen.dart';
import 'package:shopapp_v1/screen/search/search_screen.dart';
import 'package:shopapp_v1/utils/color_resource.dart';
import 'package:shopapp_v1/utils/images.dart';
import 'package:shopapp_v1/view/text_field_ui.dart';

class CustomSliverAppBar extends StatelessWidget {
  final TextEditingController searchController;

  const CustomSliverAppBar({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final productCtl = Get.find<ProductController>();

    return SliverAppBar(
        pinned: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(Images.iconShop, width: 35, height: 35),
            const SizedBox(width: 5),
            Column(
              children: [
                const SizedBox(height: 10),
                Text.rich(
                  TextSpan(children: [
                    const TextSpan(
                      text: "Grocery ",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Borel",
                      ),
                    ),
                    TextSpan(
                      text: "Store",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Borel",
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Obx(() => badges.Badge(
                position: badges.BadgePosition.topEnd(top: 4, end: -4),
                showBadge: productCtl.listCartItem.isNotEmpty,
                badgeContent: Text(
                  productCtl.listCartItem.length.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
                badgeStyle: const badges.BadgeStyle(badgeColor: Colors.red),
                child: InkWell(
                  onTap: () => Get.find<PersistentTabController>().jumpToTab(1),
                  child: Container(
                    margin: const EdgeInsets.only(top: 3),
                    height: 50,
                    width: 30,
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                    ),
                  ),
                ),
              )),
          InkWell(
            onTap: () => Get.to(() => ChatScreen()),
            child: Container(
              margin: const EdgeInsets.only(top: 3, right: 5, left: 5),
              height: 50,
              width: 30,
              child: const Icon(
                Icons.message_outlined,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: TextFieldUI(
              controller: searchController,
              readOnly: true,
              cursorColor: Colors.transparent,
              onTap: () {
                Get.to(() => SearchScreen());
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFEEF6FC),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                prefixIcon: const Icon(Icons.search,
                    color: Color(0xFF8AA0BC), size: 26),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Tìm kiếm mặt hàng",
                hintStyle: GoogleFonts.nunitoSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF8AA0BC),
                ),
              ),
            ),
          ),
        ));
  }
}
