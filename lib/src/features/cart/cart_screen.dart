import 'package:badges/badges.dart' as badges;
import 'package:notespedia/utils/constants/app_export.dart';

import 'fragment/cart_bottom_sheet.dart';
import 'fragment/sliverlist_for_cart.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final GlobalKey<ScaffoldState> cartScaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController cartScreenScrollController = ScrollController();

  final auController = Get.find<AuthenticationController>();
  final caController = Get.find<CartAndOrderController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Check if it's possible to pop the current route.
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop(); // Pop the current route.
            return false; // Prevent the system from popping the route, as we've handled it manually.
          }
          return true; // Allow the system to handle the back button (e.g., exiting the app) if no routes to pop.
        },
        child: Scaffold(
          key: cartScaffoldKey,
          bottomSheet: CartBottomSheet(),
          body: Obx(() {
            if (auController.isLoggedIn.isFalse) {
              return CustomScrollView(
                scrollDirection: Axis.vertical,
                controller: cartScreenScrollController,
                physics: const ClampingScrollPhysics(),
                slivers: [
                  buildReusableBackSliverAppbar(context),
                  SliverFillRemaining(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Please login to Access cart Session"),
                          const Gap(22),
                          ReusableMaterialButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.signInMobileRoute);
                            },
                            height: 50,
                            width: 180,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26.0),
                            ),
                            child: Text(
                              "Sign In",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            } else {
              return RefreshIndicator.adaptive(
                edgeOffset: 20,
                displacement: 80,
                onRefresh: () {
                  return caController.fetchTheItemInCart();
                },
                child: CustomScrollView(
                  scrollDirection: Axis.vertical,
                  controller: cartScreenScrollController,
                  physics: const ClampingScrollPhysics(),
                  slivers: [
                    // App bar Section
                    buildReusableBackSliverAppbar(context),

                    //
                    const SliverGap(16),

                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverListForCart(),
                    ),

                    //
                    const SliverGap(24),
                  ],
                ),
              );
            }
          }),
        ));
  }

  ReusableBackSliverAppbar buildReusableBackSliverAppbar(BuildContext context) {
    return ReusableBackSliverAppbar(
      titleText: AppTexts.cart,
      actions: [
        IconButton(
          enableFeedback: true,
          icon: const Icon(
            semanticLabel: AppTexts.search,
            AppImages.searchIcon,
            color: AppColors.greyBrightIconColor,
            size: 26,
          ),
          onPressed: () {
            Get.toNamed("/search");
          },
        ),
        IconButton(
          enableFeedback: true,
          onPressed: () {
            Get.toNamed("/notification");
          },
          icon: badges.Badge(
            showBadge: true,
            // badgeContent: Text(
            //   '3',
            //   style: Theme.of(context).textTheme.titleSmall?.copyWith(
            //         fontSize: 10,
            //         color: Colors.white,
            //       ),
            // ),
            badgeStyle: badges.BadgeStyle(badgeColor: AppColors.badgeIconColor),
            position: badges.BadgePosition.custom(top: -7, end: -7),
            child: const Icon(
              semanticLabel: AppTexts.notification,
              AppImages.notificationIcon,
              color: AppColors.greyBrightIconColor,
              size: 26,
            ),
          ),
        ),
      ],
    );
  }
}
