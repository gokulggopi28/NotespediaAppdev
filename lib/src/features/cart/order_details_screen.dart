import 'package:badges/badges.dart' as badges;
import 'package:notespedia/models/order_detail_model.dart';
import 'package:notespedia/utils/constants/app_export.dart';

class OrderDetailsScreen extends StatelessWidget {
  OrderDetailsScreen({super.key, required this.orderDetailList});

  final caController = Get.find<CartAndOrderController>();
  final OrderDetailList orderDetailList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
            ],
          ),

          //
          const SliverGap(22),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Delivered',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
              ),
            ),
          ),

          //
          const SliverGap(12),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order Date',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                  ),
                  Text(
                    "${HelperFunctions.extractDate(orderDetailList.createdOn)}  "
                    "${HelperFunctions.extractTime(orderDetailList.createdOn)}",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                  ),
                ],
              ),
            ),
          ),

          //
          const SliverGap(12),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order Id',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                  ),
                  Text(
                    orderDetailList.id.toString(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                  )
                ],
              ),
            ),
          ),

          //
          const SliverGap(12),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: Divider(),
            ),
          ),

          const SliverGap(12),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverList.separated(
              itemCount: orderDetailList.orderItems.length,
              separatorBuilder: (context, index) {
                return const Gap(12);
              },
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 140,
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [AppColors.containerShadow],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: ReusableCachedNetworkImage(
                            imageUrl: orderDetailList
                                .orderItems[index].bookCoverImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              orderDetailList.orderItems[index].bookName,
                              maxLines: 3,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            Text(
                              orderDetailList.orderItems[index].authorName,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                            const Gap(8),
                            Text(
                              "Quantity ${orderDetailList.orderItems[index].quantity}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                            const Gap(8),
                            Text(
                              "₹ ${orderDetailList.orderItems[index].bookSubTotalAmount}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),

          //
          const SliverGap(22),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cart Totals',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  Text(
                    '₹ ${orderDetailList.totalAmount}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),

          //
          const SliverGap(14),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tax',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  Text(
                    '₹ ${orderDetailList.taxAmount}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),

          //
          const SliverGap(14),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Promo discount",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  Text(
                    '₹ ${orderDetailList.discountAmount}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),

          //
          const SliverGap(45),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: Divider(),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Shipping Detail',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SliverGap(12),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                orderDetailList.shippingAddress.addressLine1.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                orderDetailList.shippingAddress.addressLine2.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),

          const SliverGap(12),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: Divider(),
            ),
          ),
          const SliverGap(12),

          SliverPadding(
            padding: const EdgeInsets.only(left: 16, right: 3.0),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Download Invoice',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(AppImages.downloadIcon),
                  ),
                ],
              ),
            ),
          ),
          const SliverGap(45),
        ],
      ),
    );
  }
}
