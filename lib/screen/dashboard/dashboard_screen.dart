import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shopapp_v1/controller/order_controller.dart';
import 'package:shopapp_v1/controller/product_controller.dart';
import 'package:shopapp_v1/controller/user_controller.dart';
import 'package:shopapp_v1/controller/wishlist_controller.dart';
import 'package:shopapp_v1/screen/cart/cart_screen.dart';
import 'package:shopapp_v1/screen/explore/explore_screen.dart';
import 'package:shopapp_v1/screen/home/home_screen.dart';
import 'package:shopapp_v1/screen/like/like_screen.dart';
import 'package:shopapp_v1/screen/profile/profile_screen.dart';
import 'package:shopapp_v1/utils/color_resource.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PersistentTabController _controller =
      Get.find<PersistentTabController>();

  Future<void> _handleTabChange(int index) async {
    final user = Get.find<UserController>().userCurrent;

    try {
      switch (index) {
        case 1:
          await Get.find<ProductController>().getProductIds();
          Get.find<ProductController>().updateTotalMoney();
          break;
        case 2:
          if (user.id != null) {
            await Get.find<WishlistController>().getWishlistByUserId(user);
          }
          break;
        case 3:
          if (user.id != null) {
            await Get.find<OrderController>().getListOrderByUserId(user.id!);
          }
          break;
      }
    } catch (e) {
      print('Tab change error: $e');
    }
  }

  List<Widget> _buildScreens() {
    return const [
      HomeScreen(),
      // ExploreScreen(),
      CartScreen(),
      LikeScreen(),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_outlined),
        title: "Home",
        activeColorPrimary: ColorResources.primaryColor,
        inactiveColorPrimary: Colors.black54,
      ),
      // PersistentBottomNavBarItem(
      //   icon: const Icon(Icons.explore_outlined),
      //   title: "Explore",
      //   activeColorPrimary: ColorResources.primaryColor,
      //   inactiveColorPrimary: Colors.black54,
      // ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.shopping_cart_outlined),
        title: "Cart",
        activeColorPrimary: ColorResources.primaryColor,
        inactiveColorPrimary: Colors.black54,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.favorite_outline),
        title: "Wishlist",
        activeColorPrimary: ColorResources.primaryColor,
        inactiveColorPrimary: Colors.black54,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person_outline),
        title: "Profile",
        activeColorPrimary: ColorResources.primaryColor,
        inactiveColorPrimary: Colors.black54,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineToSafeArea: true,
          onItemSelected: _handleTabChange,
          backgroundColor: Colors.white,
          navBarStyle: NavBarStyle.style1,
          decoration: const NavBarDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            colorBehindNavBar: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 3,
                offset: Offset(0, -1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
