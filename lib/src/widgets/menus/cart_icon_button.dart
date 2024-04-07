import 'package:badges/badges.dart' as badges;
import 'package:notespedia/utils/constants/app_export.dart';

class CartIconButton extends StatelessWidget {
  CartIconButton({
    super.key,
    required this.opacity,
  });

  final ValueNotifier<double> opacity;
  final caController = Get.find<CartAndOrderController>();

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity.value,
      duration: const Duration(milliseconds: 300),
      child: IgnorePointer(
        ignoring: opacity.value == 0.0,
        child: Obx(() {
          return IconButton(
            padding: const EdgeInsets.all(8),
            enableFeedback: true,
            onPressed: () {
              Get.toNamed(AppRoutes.cartRoute);
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
              badgeStyle:
                  badges.BadgeStyle(badgeColor: AppColors.badgeIconColor),
              position: badges.BadgePosition.custom(top: -7, end: -7),
              child: const Icon(
                AppImages.cartIcon,
                color: AppColors.greyBrightIconColor,
                size: 26,
                semanticLabel: AppTexts.cart,
              ),
            ),
          );
        }),
      ),
    );
  }
}
