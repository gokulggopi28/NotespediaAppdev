import 'package:flutter/material.dart';
import '../../../models/local/local_save_for_later_model.dart';
import '../../../utils/constants/app_export.dart';
import 'package:get/get.dart';
import '../home/controller/save_later_controller.dart'; // Correct the path as needed

class SaveForLaterBooksScreen extends StatelessWidget {
  SaveForLaterBooksScreen({Key? key}) : super(key: key);

  final SaveForLaterBooksController saveForLaterBooksController =
      Get.find<SaveForLaterBooksController>();
  final nSController = Get.find<NetworkStateController>();
  @override
  Widget build(BuildContext context) {
    saveForLaterBooksController.fetchSaveForLaterBooks();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        slivers: [
          //  const ReusableBackSliverAppbar(titleText: "Saved For Later"),
          const SliverGap(18),
          Obx(() {
            if (saveForLaterBooksController.isProcessing.isTrue) {
              return const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (saveForLaterBooksController.hasError.isTrue) {
              return SliverFillRemaining(
                child: Center(child: Text('Error loading books')),
              );
            } else if (saveForLaterBooksController
                .saveForLaterBooksList.isEmpty) {
              return SliverFillRemaining(
                child: Center(child: Text('No books Saved for Later')),
              );
            } else {
              return buildBooksGrid(
                  context, saveForLaterBooksController.saveForLaterBooksList);
            }
          }),
          const SliverGap(42),
        ],
      ),
    );
  }

  Widget buildBooksGrid(BuildContext context, List<SaveForLaterBook> books) {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = (screenWidth - (16 * 2) - (22 * (2 - 1))) / 2;

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisExtent: 330,
          maxCrossAxisExtent: itemWidth,
          crossAxisSpacing: 22,
          mainAxisSpacing: 22,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final book = books[index];
            final Map<int, Widget> statusIndicator = {
              1: const ReusableCompleteStatusIndicator(),
              2: const ReusableOngoingStatusIndicator(),
              3: const ReusableUpdateStatusIndicator(),
            };

            return SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: BookCard(
                      imageUrl: book.coverImage,
                      onTap: () async {
                        final currentBookId = book.bookId;

                        if (nSController.isInternetConnected.isTrue) {
                          await saveForLaterBooksController
                              .fetchBookDetails(currentBookId);

                          var bookDetail = saveForLaterBooksController
                              .saveforlaterbookDetailList
                              .firstWhereOrNull(
                                  (detail) => detail.bookId == currentBookId);

                          if (bookDetail != null) {
                            // If book detail is found
                            Get.to(() =>
                                BooksDetailsScreen(bookDetailData: bookDetail));
                          } else {
                            print(
                                "Book detail not found for book ID: $currentBookId");
                          }
                        } else {
                          // Handle no internet connection case
                          print("No internet connection.");
                        }
                      },
                    ),
                  ),
                  const Gap(6),
                  Row(
                    children: [
                      Expanded(
                        child: BookTitle14(
                          title: book.name,
                        ),
                      ),
                      const Gap(6),
                      // ReusableMoreOptionButton(
                      //   onPressed: () {
                      //     // Implement your logic for more options here
                      //   },
                      // ),
                    ],
                  ),
                  Row(
                    children: [
                      statusIndicator[book.stage] ??
                          const ReusableUpdateStatusIndicator(),
                      const Gap(6),
                      Expanded(
                        child: BookIndicatorText10Widget(
                          text: book.authorName,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          childCount: books.length,
        ),
      ),
    );
  }
}
