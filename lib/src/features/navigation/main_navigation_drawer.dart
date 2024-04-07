import 'package:notespedia/src/features/cart/orders_screen.dart';
import 'package:notespedia/utils/constants/app_export.dart';

class MainNavigationDrawer extends StatelessWidget {
  const MainNavigationDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //
    final textStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 0,
        );

    return Drawer(
      semanticLabel: AppTexts.drawer,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      elevation: 3.0,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 280,
              width: double.maxFinite,
              child: ReusableCachedNetworkImage(
                placeholderIndicatorEnable: false,
                imageUrl: AppImages.drawerHeader,
                fit: BoxFit.cover,
              ),
            ),
            const Gap(8),
            ListTile(
              onTap: () {
                Get.toNamed(AppRoutes.premiumPlansRoute);
              },
              horizontalTitleGap: 8,
              enableFeedback: true,
              leading: const Icon(
                AppImages.subscriptionIcon,
                size: 24,
                color: AppColors.greyBrightIconColor,
              ),
              title: Text(
                "Subscription",
                style: textStyle,
              ),
            ),
            ListTile(
              onTap: () {
                Get.to(() => OrdersScreen());
              },
              horizontalTitleGap: 8,
              enableFeedback: true,
              leading: const Icon(
                AppImages.orderIcon,
                size: 23,
                color: AppColors.greyBrightIconColor,
              ),
              title: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  "Orders",
                  style: textStyle,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Get.toNamed(AppRoutes.transactionsRoute);
              },
              horizontalTitleGap: 8,
              enableFeedback: true,
              leading: const Icon(
                AppImages.transactionsIcon,
                size: 26,
                color: AppColors.greyBrightIconColor,
              ),
              title: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  "Transaction",
                  style: textStyle,
                ),
              ),
            ),
            // ListTile(
            //   onTap: () {},
            //   horizontalTitleGap: 8,
            //   enableFeedback: true,
            //   leading: const Icon(
            //     AppImages.coinsIcon,
            //     size: 20,
            //     color: AppColors.greyBrightIconColor,
            //   ),
            //   title: Padding(
            //     padding: const EdgeInsets.only(top: 4.0),
            //     child: Text(
            //       "NP coin balance",
            //       style: textStyle,
            //     ),
            //   ),
            // ),
            // const Gap(8),
            // buildStorageListTile(context),
          ],
        ),
      ),
    );
  }

  ListTile buildStorageListTile(BuildContext context) {
    return ListTile(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                AppImages.storageIcon,
                size: 24,
                color: AppColors.greyBrightIconColor,
              ),
              const Gap(8),
              Text(
                'Storage',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
              )
            ],
          ),
          const Gap(8),
        ],
      ),
      trailing: SizedBox(
        width: 80,
        height: 40,
        child: OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(
                color: Color(0xFF0678CE),
                width: 1.5,
              ),
            ),
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF0678CE),
            alignment: Alignment.center,
            padding: EdgeInsets.zero,
          ),
          child: Text(
            'Buy',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: const Color(0xFF0678CE),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
          ),
        ),
      ),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ReusableLinearProgressIndicator(
            value: 50 / 100,
            backgroundColor: Colors.grey,
          ),
          const Gap(8),
          Text(
            '3.7 GB of 10.0 GB used',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
          ),
        ],
      ),
    );
  }
}
