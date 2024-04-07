import 'package:notespedia/utils/constants/app_export.dart';

import 'fragment/staff_toggle_action_chip.dart';

class StaffBasedBooksScreen extends StatelessWidget {
  StaffBasedBooksScreen({
    super.key,
  });

  final stController = Get.find<StaffPublisherController>();
  final nSController = Get.find<NetworkStateController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        controller: stController.gridviewScrollController,
        physics: const ClampingScrollPhysics(),
        slivers: [
          // Sliver App bar Section
          ReusableBackSliverAppbar(
            actions: [
              StaffToggleActionChip(),
              const Gap(6),
            ],
          ),

          const SliverGap(18),
          Obx(() {
            if (stController.isProcessing.isTrue) {
              return const BookLoadingSliverGridShimmer();
            } else if (stController.hasError.isTrue) {
              return const BookLoadingSliverGridShimmer();
            } else if (stController.bookListByStaffId.isEmpty) {
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
                                imageUrl: stController
                                    .bookListByStaffId[index].coverImage,
                                onTap: () async {
                                  final currentBookId = stController
                                      .bookListByStaffId[index].bookId;
                                  if (nSController.isInternetConnected.isTrue) {
                                    await stController
                                        .fetchBookDetails(currentBookId);
                                    var bookDetailController = stController
                                        .staffBooksDetailList
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
                                  title: stController
                                      .bookListByStaffId[index].bookName,
                                ),
                              ),
                              const Gap(16),
                              ReusableMoreOptionButton(
                                onPressed: () {},
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: stController.bookListByStaffId.length,
                ),
              );
            }
          }),

          //
          Obx(() {
            return SliverVisibility(
              visible: stController.bookListByStaffId.isEmpty ? false : true,
              sliver: const SliverGap(42),
            );
          }),
        ],
      ),
    );
  }
}
