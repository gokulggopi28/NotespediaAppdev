import 'package:badges/badges.dart' as badges;
import 'package:notespedia/utils/constants/app_export.dart';

import '../detailed/webview_screen.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key});

  final caController = Get.find<CartAndOrderController>();

  @override
  Widget build(BuildContext context) {
    caController.refreshOrders();
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
            body: RefreshIndicator(
          onRefresh: () async {
            return caController.refreshOrders();
          },
          child: CustomScrollView(
            slivers: [
              //
              ReusableBackSliverAppbar(
                titleText: "Your Orders",
                actions: [
                  IconButton(
                    padding: const EdgeInsets.all(8),
                    enableFeedback: true,
                    onPressed: () {
                      Get.toNamed(AppRoutes.searchRoute);
                    },
                    icon: const Icon(
                      AppImages.searchIcon,
                      color: AppColors.greyBrightIconColor,
                      size: 26,
                      semanticLabel: AppTexts.search,
                    ),
                  ),
                  Obx(() {
                    return IconButton(
                      padding: const EdgeInsets.all(8),
                      enableFeedback: true,
                      onPressed: () {
                        Get.toNamed(AppRoutes.cartRoute);
                      },
                      icon: badges.Badge(
                        showBadge:
                            caController.cartItemList.length.toString() == "0"
                                ? false
                                : true,
                        badgeContent: Text(
                          caController.cartItemList.length.toString(),
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                        ),
                        badgeStyle: badges.BadgeStyle(
                            badgeColor: AppColors.badgeIconColor),
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
                ],
              ),

              //
              const SliverGap(22),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: Obx(() {
                  if (caController.isOrderProcessing.isTrue) {
                    return const SliverToBoxAdapter(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return SliverList.separated(
                      separatorBuilder: (context, index) {
                        return const Gap(12);
                      },
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            final currentOrderId =
                                caController.orderItemList[index].orderId;
                            await caController.fetchTheDetailList(
                                orderId: currentOrderId);

                            var controllerData = caController.orderDetailList
                                .firstWhere(
                                    (element) => element.id == currentOrderId);

                            final orderDetailsUrl = caController
                                .orderItemList[index].orderDetailsUrl;
                            if (orderDetailsUrl.isNotEmpty) {
                              Get.to(CheckoutWebViewScreen(
                                  checkoutUrl: orderDetailsUrl));
                            }
                          },
                          child: Container(
                            height: 140,
                            width: double.infinity,
                            padding: const EdgeInsets.only(
                                left: 12, right: 12, top: 12, bottom: 12),
                            alignment: AlignmentDirectional.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              boxShadow: [AppColors.containerShadow],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 90,
                                  height: double.maxFinite,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    boxShadow: [AppColors.containerShadow],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: ReusableCachedNetworkImage(
                                      imageUrl: caController
                                          .orderItemList[index].bookCoverImage,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Gap(22),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Order Number: ${caController.orderItemList[index].orderNumber}",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                        ),
                                      ),
                                      const Gap(4),
                                      Text(
                                        caController
                                            .orderItemList[index].bookName,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                        ),
                                      ),
                                      const Gap(4),
                                      Text(
                                        caController
                                                .orderItemList[index].orderId
                                                .toString()
                                                .isNotEmpty
                                            ? 'Status: ${caController.orderItemList[index].orderStatusText}'
                                            : 'Unavailable',
                                        style: const TextStyle(
                                          color: Color(0xB24F4F4F),
                                          fontSize: 12,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                        ),
                                      ),
                                      // const Gap(4),
                                      // Text(
                                      //   caController.orderItemList[index]
                                      //               .orderId
                                      //               .toString() ==
                                      //           ""
                                      //       ? 'Date: ${caController.orderItemList[index].orderStatusDate}'
                                      //       : 'Unavailable',
                                      //   style: const TextStyle(
                                      //     color: Color(0xB24F4F4F),
                                      //     fontSize: 12,
                                      //     fontFamily: 'Inter',
                                      //     fontWeight: FontWeight.w500,
                                      //     height: 0,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                                const Gap(22),
                                // Icon(
                                //       BootstrapIcons.arrow_90deg_right,color: Colors.black,
                                //     ),
                                // IconButton(
                                //   onPressed: () async {
                                //     final currentOrderId =
                                //         caController.orderItemList[index].orderId;
                                //     await caController.fetchTheDetailList(
                                //         orderId: currentOrderId);
                                //
                                //     var controllerData = caController
                                //         .orderDetailList
                                //         .firstWhere((element) =>
                                //             element.id == currentOrderId);
                                //
                                //     final orderDetailsUrl = caController
                                //         .orderItemList[index].orderDetailsUrl;
                                //     if (orderDetailsUrl.isNotEmpty) {
                                //       Get.to(CheckoutWebViewScreen(
                                //           checkoutUrl: orderDetailsUrl));
                                //     }
                                //   },
                                //   icon: const Icon(
                                //     BootstrapIcons.arrow_90deg_right,
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: caController.orderItemList.length,
                    );
                  }
                }),
              ),
              const SliverGap(42),
            ],
          ),
        )));
  }
}
