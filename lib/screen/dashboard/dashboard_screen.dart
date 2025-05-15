import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import 'package:shopapp_v1/screen/cart/cart_screen.dart';
import 'package:shopapp_v1/screen/home/home_screen.dart';
import 'package:shopapp_v1/screen/like/like_screen.dart';
import 'package:shopapp_v1/screen/order/order_screen.dart';
import 'package:shopapp_v1/screen/profile/profile_screen.dart';
import 'package:shopapp_v1/utils/color_resource.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return const [
      HomeScreen(),
      OrderScreen(),
      CartScreen(),
      LikeScreen(),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_outlined),
        title: ("Home"),
        activeColorPrimary: ColorResources.primaryColor,
        inactiveColorPrimary: Colors.black54,
        textStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.list_alt),
        title: ("Orders"),
        activeColorPrimary: ColorResources.primaryColor,
        inactiveColorPrimary: Colors.black54,
        textStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.shopping_cart_outlined),
        title: ("Cart"),
        activeColorPrimary: ColorResources.primaryColor,
        inactiveColorPrimary: Colors.black54,
        textStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.favorite_outline),
        title: ("Wishlist"),
        activeColorPrimary: ColorResources.primaryColor,
        inactiveColorPrimary: Colors.black54,
        textStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person_outline),
        title: ("Profile"),
        activeColorPrimary: ColorResources.primaryColor,
        inactiveColorPrimary: Colors.black54,
        textStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineToSafeArea: true,
        backgroundColor: Colors.white,
        navBarStyle: NavBarStyle.style1,
        decoration: const NavBarDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            colorBehindNavBar: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 3,
                offset: Offset(0, -1),
              ),
            ]),
      ),
    );
  }
}
