import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notespedia/utils/constants/app_export.dart'; // Adjust this import as necessary
import '../controller/save_later_controller.dart'; // Correct this import path as per your project structure

class ListviewSaveForLaterBooks extends StatelessWidget {
  ListviewSaveForLaterBooks({Key? key}) : super(key: key);

  final SaveForLaterBooksController saveForLaterBooksController =
      Get.put(SaveForLaterBooksController());
  final nSController = Get.find<NetworkStateController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (saveForLaterBooksController.isProcessing.isTrue) {
        return const Center(child: CircularProgressIndicator());
      } else if (saveForLaterBooksController.hasError.isTrue) {
        return Center(child: Text('Error loading books'));
      } else if (saveForLaterBooksController.saveForLaterBooksList.isEmpty) {
        return const Center(child: Text('No data found'));
      } else {
        return SizedBox(
          height: 330,
          width: double.infinity,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: saveForLaterBooksController.saveForLaterBooksList.length,
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            separatorBuilder: (context, index) => const Gap(22),
            itemBuilder: (context, index) {
              final book =
                  saveForLaterBooksController.saveForLaterBooksList[index];
              final Map<int, Widget> statusIndicator = {
                0: const ReusableCompleteStatusIndicator(),
                1: const ReusableOngoingStatusIndicator(),
                2: const ReusableUpdateStatusIndicator(),
              };

              return SizedBox(
                width: 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: BookCard(
                        imageUrl: book.coverImage,
                        onTap: () async {
                          final currentBookId = book
                              .bookId; // Directly use bookId from the book object

                          if (nSController.isInternetConnected.isTrue) {
                            await saveForLaterBooksController
                                .fetchBookDetails(currentBookId);

                            var bookDetail = saveForLaterBooksController
                                .saveforlaterbookDetailList
                                .firstWhereOrNull(
                                    (detail) => detail.bookId == currentBookId);

                            if (bookDetail != null) {
                              // If book detail is found
                              Get.to(() => BooksDetailsScreen(
                                  bookDetailData: bookDetail));
                            } else {
                              // Book detail not found, handle appropriately
                              print(
                                  "Book detail not found for book ID: $currentBookId");
                              // Consider using Get.snackbar or a similar method to notify the user.
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
                        //     moreOptionsBottomSheetForContinueReading(
                        //         context, index);
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
          ),
        );
      }
    });
  }
}
