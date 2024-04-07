import 'package:notespedia/utils/constants/app_export.dart';

class SliverGridviewSearchResult extends StatelessWidget {
  SliverGridviewSearchResult({
    super.key,
  });

  final seController = Get.put(SearchScreenController());
  final nSController = Get.find<NetworkStateController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (seController.hasError.isTrue) {
        return const BookLoadingSliverGridShimmer();
      } else if (seController.isProcessing.isTrue) {
        return const BookLoadingSliverGridShimmer();
      } else {
        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisExtent: 290,
              maxCrossAxisExtent: 170,
              crossAxisSpacing: 22,
              mainAxisSpacing: 22,
            ),
            delegate: SliverChildBuilderDelegate(
              childCount: seController.searchBooksList.length,
              (context, index) {
                final book = seController.searchBooksList[index];
                return AnimatedGestureDetector(
                  child: SizedBox(
                    width: 170,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: BookCard(
                            imageUrl: seController
                                .searchBooksList[index].bookCoverImage,
                            onTap: () async {
                              final currentBookId = book.bookId;
                              if (nSController.isInternetConnected.isTrue) {
                                var bookDetail = seController
                                    .searchbookDetailList
                                    .firstWhereOrNull((detail) =>
                                        detail.bookId == currentBookId);
                                if (bookDetail == null) {
                                  await seController
                                      .fetchBookDetails(currentBookId);
                                  bookDetail = seController.searchbookDetailList
                                      .firstWhereOrNull((detail) =>
                                          detail.bookId == currentBookId);
                                }
                                if (bookDetail != null) {
                                  Get.to(() => BooksDetailsScreen(
                                      bookDetailData: bookDetail!));
                                } else {
                                  print(
                                      "Book detail not found for book ID: $currentBookId");
                                }
                              } else {
                                print("No internet connection.");
                              }
                            },
                          ),
                        ),
                        const Gap(6),
                        BookTitle14(
                          maxLines: 1,
                          title: HelperFunctions.capitalizeFirstLetter(
                              seController.searchBooksList[index].bookName),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }
    });
  }

  Widget searchBookLoadingShimmer() {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisExtent: 300,
        maxCrossAxisExtent: 170,
        crossAxisSpacing: 22,
        mainAxisSpacing: 22,
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                  ),
                ),
              ),
              const Gap(6),
              Container(
                height: 8,
                width: 170,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
              ),
              const Gap(6),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 10,
                    width: 10,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Gap(6),
                  Container(
                    height: 8,
                    width: 90,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      itemCount: 12,
    );
  }
}
