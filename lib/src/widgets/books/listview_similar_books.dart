import 'package:notespedia/utils/constants/app_export.dart';

class ListviewSimilarBooks extends StatelessWidget {
  ListviewSimilarBooks({
    super.key,
  });

  final bdController = Get.find<BooksDetailController>();
  final ctController = Get.find<BooksCategoryController>();
  var suggestionbasedBooksDetailList = <BookDetailData>[].obs;
  final nSController = Get.find<NetworkStateController>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      width: double.infinity,
      child: Obx(() {
        return ListView.separated(
            itemCount: bdController.bookSuggestionList.length,
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
                      bdController.bookSuggestionList[index].bookId;
                  if (nSController.isInternetConnected.isTrue) {
                    await bdController.fetchBookSuggestedDetails(currentBookId);
                    await bdController.fetchSuggestedBooks(currentBookId);
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
                  imageUrl: bdController.bookSuggestionList[index].coverImage,
                ),
              );
            });
      }),
    );
  }
}
