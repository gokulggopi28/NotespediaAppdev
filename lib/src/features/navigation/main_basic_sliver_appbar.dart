import 'package:badges/badges.dart' as badges;
import 'package:notespedia/utils/constants/app_export.dart';

class MainBasicSliverAppbar extends StatelessWidget {
  MainBasicSliverAppbar({
    super.key,
    required this.onPressed,
    this.text,
    this.elevation,
  });
  final caController = Get.find<CartAndOrderController>();

  final VoidCallback onPressed;
  final String? text;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      excludeHeaderSemantics: true,
      pinned: true,
      stretch: false,
      centerTitle: false,
      forceElevated: true,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      foregroundColor: Colors.black,
      shadowColor: Colors.black,
      elevation: elevation ?? 0.5,
      scrolledUnderElevation: elevation ?? 0.5,
      toolbarHeight: 60.0,
      collapsedHeight: 60.0,
      // leadingWidth: 0,
      titleSpacing: 0.0,
      leading: IconButton(
        onPressed: onPressed,
        padding: const EdgeInsets.all(8),
        enableFeedback: true,
        icon: Image.asset(
          semanticLabel: AppTexts.menu,
          AppImages.menu,
          height: 24,
          width: 24,
          isAntiAlias: true,
          color: AppColors.greyBrightIconColor,
          filterQuality: FilterQuality.high,
        ),
      ),
      title: Text(
        text ?? "",
        maxLines: 1,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Get.toNamed("/search");
          },
          icon: const Icon(
            AppImages.searchIcon,
            semanticLabel: AppTexts.search,
            color: AppColors.greyBrightIconColor,
            size: 26,
          ),
        ),
        IconButton(
          onPressed: () {
            Get.toNamed("/cart");
          },
          icon: badges.Badge(
            showBadge: caController.cartItemList.length.toString() == "0"
                ? false
                : true,
            badgeContent: Text(
              caController.cartItemList.length.toString(),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 10,
                    color: Colors.white,
                  ),
            ),
            badgeStyle: badges.BadgeStyle(badgeColor: AppColors.badgeIconColor),
            position: badges.BadgePosition.custom(top: -7, end: -7),
            child: const Icon(
              AppImages.cartIcon,
              color: AppColors.greyBrightIconColor,
              size: 26,
              semanticLabel: AppTexts.cart,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            Get.toNamed("/notification");
          },
          icon: badges.Badge(
            showBadge: false,
            badgeStyle: badges.BadgeStyle(badgeColor: AppColors.badgeIconColor),
            position: badges.BadgePosition.custom(top: -7, end: -7),
            child: const Icon(
              AppImages.notificationIcon,
              semanticLabel: AppTexts.notification,
              color: AppColors.greyBrightIconColor,
              size: 26,
            ),
          ),
        ),
      ],
    );
  }
}
