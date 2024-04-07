import 'package:notespedia/src/features/home/controller/continue_reading_books_controller.dart';
import 'package:notespedia/utils/constants/app_export.dart';

class ListviewContinueReadingBooks extends StatefulWidget {
  const ListviewContinueReadingBooks({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _ListviewContinueReadingBooksState();
}

class _ListviewContinueReadingBooksState
    extends State<ListviewContinueReadingBooks> {
  late Future<AllBooks> allBooks;

  @override
  void initState() {
    allBooks = fetchReadBooksForContinuing();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AllBooks>(
      future: allBooks,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        List<LocalContinueReadingModel>? continueReadingList =
            snapshot.data?.booksList;
        return SizedBox(
          height: 350,
          child: ListView.separated(
            itemCount: continueReadingList?.length ?? 0,
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
            separatorBuilder: (context, index) {
              return const Gap(22);
            },
            itemBuilder: (context, index) {
              // DebugLogger.info("Continue Reading Visible Index: $index");

              return SizedBox(
                width: 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: BookStackCard(
                        widget: Stack(
                          children: [
                            Positioned.fill(
                              child: GestureDetector(
                                onTap: () {
                                  // Get.toNamed(AppRoutes.bookDetailsRoute);
                                },
                                child: ReusableCachedNetworkImage(
                                  imageUrl: continueReadingList?[index]
                                          .bookCoverImg ??
                                      "",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: PlaceableDownloadButton(
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ReusableLinearProgressIndicator(
                            value: localContinueReadingList[index]
                                    .chaptersReadedCount /
                                (continueReadingList?[index]
                                        .chaptersTotalCount ??
                                    0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: ReusableMoreOptionButton(
                            onPressed: () {
                              moreOptionsBottomSheetForContinueReading(
                                  context, index);
                            },
                          ),
                        ),
                      ],
                    ),
                    BookTitle14(
                      title:
                          "${continueReadingList?[index].chaptersReadedCount ?? 0}/"
                          "${continueReadingList?[index].chaptersTotalCount ?? 0}"
                          " Chapters",
                      fontSize: 12,
                    ),
                    const Gap(2),
                    Row(
                      children: [
                        const ReusableOngoingStatusIndicator(),
                        const Gap(6),
                        Expanded(
                          child: BookIndicatorText10Widget(
                            text:
                                "${continueReadingList?[index].newlyChaptersAddedCount ?? 0} "
                                "New chapters added",
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
