import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopapp_v1/utils/dimensions.dart';

void showCustomFlash(String message, BuildContext context,
    {bool isError = true}) {
  if (message.isNotEmpty) {
    context.showFlash<bool>(
      barrierColor: Colors.transparent,
      barrierBlur: 0,
      duration: const Duration(seconds: 2),
      barrierDismissible: true,
      builder: (context, controller) => FlashBar(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(15),
        useSafeArea: true,
        backgroundColor: isError == false
            ? const Color(0xFFF0FFF0)
            : const Color(0xFFF8E4CC),
        behavior: FlashBehavior.floating,
        controller: controller,
        position: FlashPosition.top,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        icon: isError == false
            ? const Icon(
                Icons.check_circle,
                color: Color(0xFF32CD32),
              )
            : const Icon(
                Icons.cancel,
                color: Color(0xFFF20231),
              ),
        content: Text(
          message,
          style: isError == false
              ? TextStyle(
                  color: const Color(0xFF32CD32),
                  fontSize: Dimensions.fontSizeLarge)
              : TextStyle(
                  color: const Color(0xFFF20231),
                  fontSize: Dimensions.fontSizeLarge),
        ),
      ),
    );
  }
}
