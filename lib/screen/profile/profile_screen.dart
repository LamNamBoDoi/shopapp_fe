import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp_v1/controller/user_controller.dart';
import 'package:shopapp_v1/screen/info/info_screen.dart';
import 'package:shopapp_v1/screen/order/order_screen.dart';
import 'package:shopapp_v1/screen/review/review_screen.dart';
import 'package:shopapp_v1/screen/setting/setting_screen.dart';
import 'package:shopapp_v1/screen/sign_in/sign_in_screen.dart';
import 'package:shopapp_v1/utils/app_constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final userCtl = Get.find<UserController>();

  final List<Map<String, dynamic>> menuItems = [
    {
      'icon': Icons.shopping_bag_outlined,
      'title': 'my_orders',
      'function': () => Get.to(() => OrderScreen())
    },
    {
      'icon': Icons.person_outline,
      'title': 'information',
      'function': () => Get.to(() => InfoScreen())
    },
    {
      'icon': Icons.stars_rounded,
      'title': 'review',
      'function': () => Get.to(() => ReviewScreen())
    },
    {'icon': Icons.help_outline, 'title': 'help', 'function': () {}},
    {
      'icon': Icons.settings,
      'title': 'settings',
      'function': () => Get.to(() => SettingScreen())
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'profile'.tr,
          style: theme.appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header Card
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withOpacity(0.3)
                        : Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            border: Border.all(
                              color: theme.colorScheme.primary.withOpacity(0.3),
                              width: 3,
                            ),
                          ),
                          child: GetBuilder<UserController>(builder: (ctl) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(55),
                              child: userCtl.userCurrent.thumbnail != null &&
                                      userCtl.userCurrent.thumbnail != ""
                                  ? Image.network(
                                      "${AppConstants.BASE_URL}${AppConstants.GET_PRODUCT}/images/${userCtl.userCurrent.thumbnail!}",
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/default_avatar.png',
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    ),
                            );
                          })),
                    ],
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userCtl.userCurrent.fullname ?? "Guest User",
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontSize: 20,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Welcome back!',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Menu Items Card
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withOpacity(0.3)
                        : Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: menuItems.length,
                separatorBuilder: (context, index) => Divider(
                  color: theme.colorScheme.onSurface.withOpacity(0.1),
                  thickness: 1,
                  height: 1,
                  indent: 56,
                ),
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    leading: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        item['icon'],
                        color: theme.colorScheme.primary,
                        size: 22,
                      ),
                    ),
                    title: Text(
                      (item['title'] as String).tr,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: theme.colorScheme.onSurface.withOpacity(0.4),
                    ),
                    onTap: item['function'],
                  );
                },
              ),
            ),

            SizedBox(height: 24),

            // Logout Button
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  userCtl.clearUser().then((_) {
                    Get.offAll(SignInScreen());
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark
                      ? Colors.red[900]?.withOpacity(0.2)
                      : Colors.red[50],
                  foregroundColor: isDark ? Colors.red[300] : Colors.red[600],
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                        color: isDark
                            ? Colors.red[300]!.withOpacity(0.3)
                            : Colors.red[200]!,
                        width: 1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout_outlined,
                      size: 22,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'logout'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
