import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notespedia/src/features/home/controller/downloads_controller.dart';
import 'package:notespedia/utils/constants/app_export.dart'; // Adjust this import as necessary
import '../../../../repositories/user_preferences.dart';
import '../../detailed/grid_view_book_list.dart';
import '../controller/downloadandopenpdf.dart';
import '../controller/save_later_controller.dart'; // Correct this import path as per your project structure

class ListviewDownloads extends StatelessWidget {
  ListviewDownloads({Key? key}) : super(key: key);

  final DownloadsController downloadsController =
      Get.put(DownloadsController());
  final nSController = Get.find<NetworkStateController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (downloadsController.isProcessing.isTrue) {
        return const Center(child: CircularProgressIndicator());
      } else if (downloadsController.hasError.isTrue) {
        return Center(child: Text('Error loading books'));
      } else if (downloadsController.downloadedBooksList.isEmpty) {
        return const Center(child: Text('No data found'));
      } else {
        return SizedBox(
          height: 330,
          width: double.infinity,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: downloadsController.downloadedBooksList.length,
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            separatorBuilder: (context, index) => const Gap(22),
            itemBuilder: (context, index) {
              final book = downloadsController.downloadedBooksList[index];
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
                          int bookId = book.bookId;
                          int userId = book.userId;
                          Get.to(() =>
                              ResponsiveGrid(bookId: bookId, userId: userId));
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
                        ReusableMoreOptionButton(
                          onPressed: () {
                            moreOptionsBottomSheetForContinueReading(
                                context, index);
                          },
                        ),
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
