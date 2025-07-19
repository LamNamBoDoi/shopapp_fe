import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar customAppBar({
  required BuildContext context,
  String title = '',
}) {
  final theme = Theme.of(context);

  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    title: Text(
      title.tr,
      style: theme.appBarTheme.titleTextStyle,
    ),
    iconTheme: theme.appBarTheme.iconTheme,
  );
}
