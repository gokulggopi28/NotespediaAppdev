import 'package:notespedia/utils/constants/app_export.dart';

class ListviewAuthorSuggestionBooks extends StatelessWidget {
  ListviewAuthorSuggestionBooks({
    super.key,
  });

  final bdController = Get.find<BooksDetailController>();
  final nSController = Get.find<NetworkStateController>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      width: double.infinity,
      child: Obx(() {
        return ListView.separated(
            itemCount: bdController.authorRelatedBookList.length,
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            separatorBuilder: (context, index) {
              return const Gap(22);
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  final currentBookId =
                      bdController.authorRelatedBookList[index].bookId;
                  if (nSController.isInternetConnected.isTrue) {
                    await bdController
                        .fetchBookAuthorSuggestedDetails(currentBookId);
                    await bdController.fetchAuthorRelatedBooks(currentBookId);
                    var bookDetailController =
                        bdController.bookDetailData.firstWhere(
                      (detail) => detail.bookId == currentBookId,
                    );
                    if (bookDetailController != null) {
                      Get.to(
                          () => BooksDetailsScreen(
                              bookDetailData: bookDetailController),
                          preventDuplicates: false);
                    }
                  } else {}
                },
                child: BookCard(
                  imageUrl:
                      bdController.authorRelatedBookList[index].coverImage,
                ),
              );
            });
      }),
    );
  }
}
