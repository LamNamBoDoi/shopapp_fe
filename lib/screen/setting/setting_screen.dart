import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp_v1/controller/localization_controller.dart';
import 'package:shopapp_v1/controller/theme_controller.dart';
import 'package:shopapp_v1/utils/app_constants.dart';
import 'package:shopapp_v1/view/custom_appbar.dart';
import 'package:shopapp_v1/view/dropdown_item.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  RxBool isSelectedLanguage = false.obs;
  RxBool isSelectedTheme = false.obs;
  final localizationController = Get.find<LocalizationController>();
  final themeController = Get.find<ThemeController>();

  // Tạo danh sách language items
  List<DropdownItem> _getLanguageItems() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return [
      DropdownItem(
        title: "lang_vi".tr,
        icon: Icons.flag,
        iconColor: isDark ? Colors.red[300] : Colors.redAccent,
        isSelected: localizationController.selectedIndex == 0,
        onTap: () {
          localizationController.setSelectIndex(0);
          Get.find<LocalizationController>().setLanguage(Locale(
            AppConstants.languages[0].languageCode,
            AppConstants.languages[0].countryCode,
          ));
          isSelectedLanguage.value = false;
        },
      ),
      DropdownItem(
        title: "lang_en".tr,
        icon: Icons.flag,
        iconColor: isDark ? Colors.blue[300] : Colors.blueAccent,
        isSelected: localizationController.selectedIndex == 1,
        onTap: () {
          localizationController.setSelectIndex(1);
          Get.find<LocalizationController>().setLanguage(Locale(
            AppConstants.languages[1].languageCode,
            AppConstants.languages[1].countryCode,
          ));
          isSelectedLanguage.value = false;
        },
      ),
    ];
  }

  // Tạo danh sách theme items
  List<DropdownItem> _getThemeItems() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return [
      DropdownItem(
        title: "light_mode".tr,
        icon: Icons.light_mode,
        iconColor: isDark ? Colors.orange[300] : Colors.orange,
        isSelected: themeController.darkTheme == false,
        onTap: () {
          if (themeController.darkTheme == true) {
            Get.find<ThemeController>().toggleTheme();
          }
          isSelectedTheme.value = false;
        },
      ),
      DropdownItem(
        title: "dark_mode".tr,
        icon: Icons.dark_mode,
        iconColor: isDark ? Colors.grey[300] : Colors.black87,
        isSelected: themeController.darkTheme == true,
        onTap: () {
          if (themeController.darkTheme == false) {
            Get.find<ThemeController>().toggleTheme();
          }
          isSelectedTheme.value = false;
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: customAppBar(context: context, title: 'settings'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Column(
              children: [
                // Language Dropdown
                CustomDropdownWidget(
                  title: "language".tr,
                  leadingIcon: Icons.language,
                  leadingIconColor: theme.colorScheme.primary,
                  isExpanded: isSelectedLanguage.value,
                  onHeaderTap: () => isSelectedLanguage.toggle(),
                  items: _getLanguageItems(),
                ),

                const SizedBox(height: 15),

                // Theme Dropdown
                CustomDropdownWidget(
                  title: "theme".tr,
                  leadingIcon: Icons.color_lens,
                  leadingIconColor: theme.colorScheme.secondary,
                  isExpanded: isSelectedTheme.value,
                  onHeaderTap: () => isSelectedTheme.toggle(),
                  items: _getThemeItems(),
                ),
              ],
            )),
      ),
    );
  }
}
