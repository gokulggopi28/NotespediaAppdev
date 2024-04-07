import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:notespedia/utils/constants/app_export.dart';
import 'package:notespedia/utils/helpers/device_helper.dart';

class SliverListForCart extends StatefulWidget {
  SliverListForCart({Key? key}) : super(key: key);

  @override
  _SliverListForCartState createState() => _SliverListForCartState();
}

class _SliverListForCartState extends State<SliverListForCart> {
  late Map<int, int> itemQuantities;
  @override
  void initState() {
    super.initState();
    final cartAndOrderController = Get.find<CartAndOrderController>();
    itemQuantities = {
      for (var item in cartAndOrderController.cartItemList)
        item.bookId: item.quantity
    };
  }

  @override
  Widget build(BuildContext context) {
    final nSController = Get.find<NetworkStateController>();
    final caController = Get.find<CartAndOrderController>();
    final bdController = Get.find<BooksDetailController>();

    return Obx(() {
      if (caController.isProcessing.isTrue) {
        return const SliverToBoxAdapter(
          child: ReusableCircularProgressIndicator(),
        );
      } else if (caController.cartItemList.isEmpty) {
        return SliverToBoxAdapter(
          child: Center(child: Text("No items in the cart")),
        );
      } else if (caController.hasError.isTrue) {
        return const SliverGap(0);
      } else {
        return SliverList.separated(
          itemCount: caController.cartItemList.length,
          separatorBuilder: (context, index) => const Gap(12),
          itemBuilder: (context, index) {
            final item = caController.cartItemList[index];
            int quantity = itemQuantities[item.bookId] ?? 1;

            return Padding(
              padding: EdgeInsets.only(
                bottom: index == caController.cartItemList.length - 1
                    ? DeviceHelper.getScreenHeight(context) * .40
                    : 0.0,
              ),
              child: Slidable(
                key: ValueKey(item.itemId),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) async {
                        await caController.deleteItemInCart(
                            ctx: context, selectedItemId: item.itemId);
                      },
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: AppImages.deleteIcon,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: Container(
                  height: 140,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    boxShadow: [AppColors.containerShadow],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                // Add your onTap functionality here
                                print("Book cover tapped!");
                                final bookId =
                                    caController.cartItemList[index].bookId;
                                if (nSController.isInternetConnected.isTrue) {
                                  await caController.fetchBookDetails(bookId);
                                  var bookDetailController =
                                      caController.cartOrderList.firstWhere(
                                          (detail) => detail.bookId == bookId);
                                  Get.to(
                                    () => BooksDetailsScreen(
                                      bookDetailData: bookDetailController,
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                width: 80,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  boxShadow: [AppColors.containerShadow],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: ReusableCachedNetworkImage(
                                    imageUrl: item.bookCoverImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const Gap(10),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.bookName,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                  Text(item.authorName,
                                      style: TextStyle(
                                          color: Color(0xFF828080),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400)),
                                  Text("₹${item.bookPrice}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 15,
                            child: IconButton(
                              icon: Icon(Icons.remove,
                                  color: Colors.white, size: 16),
                              onPressed: () {
                                setState(() {
                                  // Decrement the quantity safely
                                  final currentQuantity =
                                      itemQuantities[item.bookId] ??
                                          1; // Safely handle null
                                  itemQuantities[item.bookId] =
                                      max(1, currentQuantity - 1);
                                });
                                // Call the API to update the cart item quantity, using the updated quantity
                                caController.updateCartItem(
                                  ctx: context,
                                  id: item.itemId,
                                  cartId: item.cartId,
                                  bookId: item.bookId,
                                  quantity: itemQuantities[item
                                      .bookId]!, // Now safe to use ! since it's updated above
                                );
                              },
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                            ),
                          ),
// Similar adjustment for the "+" button

                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text('${itemQuantities[item.bookId] ?? 1}',
                                style: TextStyle(fontSize: 16)),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 15,
                            child: IconButton(
                              icon: Icon(Icons.add,
                                  color: Colors.white, size: 16),
                              onPressed: () {
                                setState(() {
                                  final currentQuantity =
                                      itemQuantities[item.bookId] ??
                                          1; // Safely handle null
                                  itemQuantities[item.bookId] =
                                      currentQuantity + 1;
                                });
                                // Similar update call as above for increment
                                caController.updateCartItem(
                                  ctx: context,
                                  id: item.itemId,
                                  cartId: item.cartId,
                                  bookId: item.bookId,
                                  quantity: itemQuantities[item
                                      .bookId]!, // Now safe to use ! since it's updated above
                                );
                              },
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }
    });
  }
}
