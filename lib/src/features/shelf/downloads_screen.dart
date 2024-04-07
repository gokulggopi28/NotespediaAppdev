import 'package:flutter/material.dart';
import 'package:notespedia/models/downloads_model.dart';
import 'package:notespedia/src/features/home/controller/downloads_controller.dart';
import '../../../models/local/local_save_for_later_model.dart';
import '../../../repositories/user_preferences.dart';
import '../../../utils/constants/app_export.dart';
import 'package:get/get.dart';
import '../detailed/grid_view_book_list.dart';
import '../home/controller/downloadandopenpdf.dart';
import '../home/controller/save_later_controller.dart'; // Correct the path as needed

class DownloadsScreen extends StatelessWidget {
  DownloadsScreen({Key? key}) : super(key: key);

  final DownloadsController downloadsController =
      Get.find<DownloadsController>();
  final nSController = Get.find<NetworkStateController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        slivers: [
          const ReusableBackSliverAppbar(titleText: "Downloads"),
          const SliverGap(18),
          Obx(() {
            if (downloadsController.isProcessing.isTrue) {
              return const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (downloadsController.hasError.isTrue) {
              return SliverFillRemaining(
                child: Center(child: Text('Error loading books')),
              );
            } else {
              return buildBooksGrid(
                  context, downloadsController.downloadedBooksList);
            }
          }),
          const SliverGap(42),
        ],
      ),
    );
  }

  Widget buildBooksGrid(BuildContext context, List<DownloadData> books) {
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
                          // Implement your logic for more options here
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
          childCount: books.length,
        ),
      ),
    );
  }
}
