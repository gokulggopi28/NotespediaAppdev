import 'package:badges/badges.dart' as badges;
import 'package:notespedia/utils/constants/app_export.dart';

class ProfileSliverAppbar extends StatelessWidget {
  ProfileSliverAppbar({
    super.key,
  });
  final caController = Get.find<CartAndOrderController>();
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      backgroundColor: Colors.transparent,
      forceMaterialTransparency: true,
      floating: true,
      snap: true,
      toolbarHeight: 60,
      leading: IconButton(
        onPressed: () {
          Get.toNamed(AppRoutes.cartRoute);
        },
        icon: badges.Badge(
          showBadge:
              caController.cartItemList.length.toString() == "0" ? false : true,
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
      actions: [
        IconButton(
          onPressed: () {
            Get.toNamed(AppRoutes.settingsRoute);
          },
          icon: const Icon(
            AppImages.settingsIcon,
            color: AppColors.greyBrightIconColor,
            size: 26,
          ),
        ),
      ],
    );
  }
}
