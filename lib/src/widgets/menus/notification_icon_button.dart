import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notespedia/utils/constants/app_export.dart';

class NotificationIconButton extends StatelessWidget {
  const NotificationIconButton({
    super.key,
    required this.opacity,
  });

  final ValueNotifier<double> opacity;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity.value,
      duration: const Duration(milliseconds: 300),
      child: IgnorePointer(
        ignoring: opacity.value == 0.0,
        child: IconButton(
          padding: const EdgeInsets.all(8),
          enableFeedback: true,
          onPressed: () {
            Get.toNamed(AppRoutes.notificationRoute);
          },
          icon: Icon(
            AppImages.notificationIcon,
            color: AppColors.greyBrightIconColor,
            size: 26,
            semanticLabel: AppTexts.notification,
          ),
        ),
      ),
    );
  }
}
