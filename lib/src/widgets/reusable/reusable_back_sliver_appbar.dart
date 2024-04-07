import 'package:notespedia/utils/constants/app_export.dart';

import '../../features/home/controller/new_fresh_released_controller.dart';

class ReusableBackSliverAppbar extends StatelessWidget {
  const ReusableBackSliverAppbar({
    super.key,
    this.title,
    this.titleText,
    this.actions,
    this.centerTitle = false,
    this.elevation,
    this.scrolledUnderElevation,
    this.titleSpacing,
    this.toolbarHeight,
    this.leadingWidth,
  });

  final Widget? title;
  final List<Widget>? actions;
  final bool? centerTitle;
  final String? titleText;
  final double? elevation;
  final double? scrolledUnderElevation;
  final double? titleSpacing;
  final double? toolbarHeight;
  final double? leadingWidth;

  @override
  Widget build(BuildContext context) {
    final nfrController = Get.put(NewFreshReleaseController());
    return SliverAppBar(
      automaticallyImplyLeading: false,
      floating: true,
      forceElevated: true,
      centerTitle: centerTitle,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.black,
      elevation: elevation ?? 0.5,
      scrolledUnderElevation: scrolledUnderElevation ?? 0.5,
      titleSpacing: titleSpacing ?? 0,
      toolbarHeight: toolbarHeight ?? 60,
      leadingWidth: leadingWidth ?? 56.0,
      leading: IconButton(
        enableFeedback: true,
        padding: EdgeInsets.zero,
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          AppImages.backIcon,
          color: AppColors.greyBrightIconColor,
          size: 32,
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 1.0),
        child: Text(
          titleText ?? "",
          maxLines: 1,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
        ),
      ),
      actions: actions,
    );
  }
}
