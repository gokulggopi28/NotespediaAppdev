import 'package:notespedia/src/widgets/bottomsheet/filter_selection_bottom_sheet.dart';
import 'package:notespedia/utils/constants/app_export.dart';

import '../../widgets/bottomsheet/category_selection_bottom_sheet.dart';
import 'controller/new_fresh_released_controller.dart';

class FreshReleasedBooksScreen extends StatelessWidget {
  FreshReleasedBooksScreen({super.key});

  final frController = Get.put(FreshReleaseController());
  final nfrController = Get.put(NewFreshReleaseController());
  final nSController = Get.find<NetworkStateController>();
  final bdController = Get.find<BooksDetailController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
        edgeOffset: 20,
        displacement: 80,
        onRefresh: () {
          return frController.refreshFreshReleaseBooks();
        },
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          controller: nfrController.gridviewScrollController,
          physics: const ClampingScrollPhysics(),
          slivers: [
            ReusableBackSliverAppbar(
              titleText: "Fresh Release",
              actions: [
                IconButton(
                  icon: Image.asset(
                    'assets/images/icons/filter.png',
                    width: 20,
                    height: 20,
                  ),
                  onPressed: () {
                    filterSelectionBottomSheet(context);
                    print('Filter Icon Tapped');
                  },
                ),
              ],
            ),
            const SliverGap(18),
            Obx(() {
              if (nfrController.hasError.isTrue) {
                return const BookLoadingSliverGridShimmer();
              } else if (nfrController.isProcessing.isTrue) {
                return const BookLoadingSliverGridShimmer();
              } else if (nfrController.newfreshReleaseBookList.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(child: Text("No Books Found")),
                );
              } else {
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 290,
                      maxCrossAxisExtent: 170,
                      crossAxisSpacing: 22,
                      mainAxisSpacing: 22,
                    ),
                    itemBuilder: (context, index) {
                      if (index < frController.freshReleaseBookList.length) {
                        return AnimatedGestureDetector(
                          child: SizedBox(
                            width: 170,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: BookCard(
                                    imageUrl: frController
                                        .freshReleaseBookList[index].coverImage,
                                    onTap: () async {
                                      final bookId = frController
                                          .freshReleaseBookList[index].bookId;
                                      await bdController.onTapBookAction(
                                        ctx: context,
                                        selectedBookId: bookId,
                                      );
                                    },
                                  ),
                                ),
                                const Gap(6),
                                BookTitle14(
                                  maxLines: 1,
                                  title: HelperFunctions.capitalizeFirstLetter(
                                      frController.freshReleaseBookList[index]
                                          .bookName),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return const Padding(
                          padding: EdgeInsets.all(22),
                          child: Center(
                            child: ReusableCircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                    itemCount: frController.isMoreDataAvailable.value
                        ? frController.freshReleaseBookList.length + 1
                        : frController.freshReleaseBookList.length,
                  ),
                );
              }
            }),
            const SliverGap(42),
          ],
        ),
      ),
    );
  }
}
