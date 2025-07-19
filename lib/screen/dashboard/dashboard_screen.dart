import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shopapp_v1/controller/order_controller.dart';
import 'package:shopapp_v1/controller/product_controller.dart';
import 'package:shopapp_v1/controller/user_controller.dart';
import 'package:shopapp_v1/controller/wishlist_controller.dart';
import 'package:shopapp_v1/screen/cart/cart_screen.dart';
import 'package:shopapp_v1/screen/home/home_screen.dart';
import 'package:shopapp_v1/screen/like/like_screen.dart';
import 'package:shopapp_v1/screen/profile/profile_screen.dart';

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

  final theme = Theme.of(Get.context!);

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
        icon: Icon(
          Icons.home_outlined,
          color: theme.colorScheme.secondary,
        ),
        textStyle: theme.textTheme.bodyLarge?.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: theme.colorScheme.secondary,
        ),
        title: "Home",
      ),
      // PersistentBottomNavBarItem(
      //   icon: const Icon(Icons.explore_outlined),
      //   title: "Explore",
      //   activeColorPrimary: ColorResources.primaryColor,
      //   inactiveColorPrimary: Colors.black54,
      // ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.shopping_cart_outlined,
          color: theme.colorScheme.secondary,
        ),
        textStyle: theme.textTheme.bodyLarge?.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: theme.colorScheme.secondary,
        ),
        title: "Cart",
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.favorite_outline,
          color: theme.colorScheme.secondary,
        ),
        textStyle: theme.textTheme.bodyLarge?.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: theme.colorScheme.secondary,
        ),
        title: "Wishlist",
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.person_outline,
          color: theme.colorScheme.secondary,
        ),
        title: "Profile",
        textStyle: theme.textTheme.bodyLarge?.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: theme.colorScheme.secondary,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineToSafeArea: true,
          onItemSelected: _handleTabChange,
          backgroundColor: theme.colorScheme.surface,
          navBarStyle: NavBarStyle.style1,
          decoration: NavBarDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            colorBehindNavBar: theme.scaffoldBackgroundColor,
            boxShadow: const [
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
