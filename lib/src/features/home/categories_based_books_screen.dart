import 'package:notespedia/utils/constants/app_export.dart';

import 'fragment/category_toggle_action_chip.dart';

class CategoryBasedBooksScreen extends StatelessWidget {
  CategoryBasedBooksScreen({super.key});

  final ctController = Get.find<BooksCategoryController>();
  final nSController = Get.find<NetworkStateController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        controller: ctController.gridviewScrollController,
        physics: const ClampingScrollPhysics(),
        slivers: [
          // Sliver App bar Section
          ReusableBackSliverAppbar(
            actions: [
              CategoryToggleActionChip(),
              const Gap(6),
            ],
          ),

          //
          const SliverGap(18),
          Obx(() {
            if (ctController.isProcessing.isTrue) {
              return const BookLoadingSliverGridShimmer();
            } else if (ctController.hasError.isTrue) {
              return const BookLoadingSliverGridShimmer();
            } else if (ctController.bookListByCategoryId.isEmpty) {
              return const SliverFillRemaining(
                child: ReusableResultNotFoundWidget(bottomPadding: 70),
              );
            } else {
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: 300,
                    maxCrossAxisExtent: 170,
                    crossAxisSpacing: 22,
                    mainAxisSpacing: 22,
                  ),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 170,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AnimatedGestureDetector(
                              child: BookCard(
                                imageUrl: ctController
                                    .bookListByCategoryId[index].coverImage,
                                onTap: () async {
                                  final currentBookId = ctController
                                      .bookListByCategoryId[index].bookId;
                                  if (nSController.isInternetConnected.isTrue) {
                                    await ctController
                                        .fetchBookDetails(currentBookId);
                                    var bookDetailController = ctController
                                        .categorybasedBooksDetailList
                                        .firstWhere((detail) =>
                                            detail.bookId == currentBookId);
                                    Get.to(
                                      () => BooksDetailsScreen(
                                        bookDetailData: bookDetailController,
                                      ),
                                    );
                                  } else {}
                                },
                              ),
                            ),
                          ),
                          const Gap(6),
                          Row(
                            children: [
                              Expanded(
                                child: BookTitle14(
                                  title: ctController
                                      .bookListByCategoryId[index].bookName,
                                ),
                              ),
                              const Gap(16),
                              // ReusableMoreOptionButton(
                              //   onPressed: () {},
                              // )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: ctController.bookListByCategoryId.length,
                ),
              );
            }
          }),

          // SliverPadding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   sliver: SliverGrid.builder(
          //       gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          //         mainAxisExtent: 300,
          //         maxCrossAxisExtent: 170,
          //         crossAxisSpacing: 22,
          //         mainAxisSpacing: 22,
          //       ),
          //       itemBuilder: (context, index) {
          //         return SizedBox(
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Expanded(
          //                 child: BookCard(
          //                   imageUrl: ctController
          //                       .bookListByCategoryId[index].coverImage,
          //                   //localFreshReleaseBooksList[index].bookCoverImg,
          //                   onTap: () {
          //                     // Get.toNamed(AppRoutes.bookDetailsRoute);
          //                   },
          //                 ),
          //               ),
          //               const Gap(6),
          //               Row(
          //                 children: [
          //                   Expanded(
          //                     child: BookTitle14(
          //                       title: ctController
          //                           .bookListByCategoryId[index].coverImage,
          //                       // localFreshReleaseBooksList[index].bookTitle,
          //                     ),
          //                   ),
          //                   const Gap(16),
          //                   ReusableMoreOptionButton(
          //                     onPressed: () {},
          //                   )
          //                 ],
          //               ),
          //             ],
          //           ),
          //         );
          //       },
          //       itemCount: ctController.bookListByCategoryId
          //           .length //localFreshReleaseBooksList.length,
          //       ),
          // ),

          //
          Obx(() {
            return SliverVisibility(
              visible: ctController.bookListByCategoryId.isEmpty ? false : true,
              sliver: const SliverGap(42),
            );
          }),
        ],
      ),
    );
  }
}
