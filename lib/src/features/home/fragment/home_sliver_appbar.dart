import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notespedia/utils/constants/app_export.dart';

import '../../../widgets/menus/cart_icon_button.dart';
import '../../../widgets/menus/course_selection_action_chip.dart';
import '../../../widgets/menus/menu_icon_button.dart';
import '../../../widgets/menus/notification_icon_button.dart';
import '../../../widgets/menus/search_icon_button.dart';
import '../../../widgets/menus/sliver_flexible_space.dart'; // Ensure this import is correct for your project structure

class HomeSliverAppBar extends StatelessWidget {
  HomeSliverAppBar({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;
  final ValueNotifier<double> _fullOpacity = ValueNotifier<double>(1.0);
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      excludeHeaderSemantics: true,
      pinned: true, // Keeps the AppBar pinned at the top
      stretch: true,
      centerTitle: false,
      forceElevated: false,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      foregroundColor: Colors.black,
      shadowColor: Colors.grey,
      elevation: 0,
      scrolledUnderElevation: 0.5,
      toolbarHeight: 60.0,
      collapsedHeight: 60.0,
      expandedHeight:
          100.0, // Adjust if you want a different height when scrolled
      leadingWidth: 0,
      titleSpacing: 0,
      flexibleSpace: FlexibleSpaceBar(
        background:
            const SliverFlexibleSpace(), // Your custom flexible space widget
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MenuIconButton(
              onPressed: onPressed,
              opacity: _fullOpacity), // Custom widget for menu icon
          const Gap(8), // Adjust gap as needed
          CourseSelectionActionChip(
            opacity: _fullOpacity,
          ), // Custom widget for course selection chip
        ],
      ),
      actions: [
        SearchIconButton(opacity: _fullOpacity),
        CartIconButton(opacity: _fullOpacity),
        NotificationIconButton(opacity: _fullOpacity),
      ],
    );
  }
}
