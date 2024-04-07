import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notespedia/utils/constants/app_export.dart'; // Verify this import

class CourseSelectionActionChip extends StatelessWidget {
  CourseSelectionActionChip({
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
        child: ActionChip(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
            top: 5.0,
            bottom: 5.0,
          ),
          labelPadding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          side: BorderSide(
            color: AppColors.greyBrightIconColor.withOpacity(.3),
            width: .5,
          ),
          elevation: 5,
          pressElevation: 5,
          label: SizedBox(
            width: 100,
            child: Row(
              children: [
                Expanded(
                  child: Obx(() {
                    final coController = Get.find<CourseSelectionController>();
                    return Text(
                      coController.courseList.isNotEmpty
                          ? coController
                              .courseList[coController.selectedIndex.value]
                              .courseName
                          : "Select Course",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                    );
                  }),
                ),
                const Icon(
                  AppImages.dropDownIcon,
                  color: AppColors.greyBrightIconColor,
                  size: 26,
                ),
              ],
            ),
          ),
          onPressed: () => courseSelectionBottomSheet(context),
        ),
      ),
    );
  }
}
