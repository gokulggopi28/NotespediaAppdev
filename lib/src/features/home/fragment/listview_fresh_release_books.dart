import 'package:notespedia/utils/constants/app_export.dart';

class ListviewFreshReleaseBooks extends StatelessWidget {
  ListviewFreshReleaseBooks({
    super.key,
  });

  final nSController = Get.find<NetworkStateController>();
  final frController = Get.find<FreshReleaseController>();
  final bdController = Get.find<BooksDetailController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      width: double.infinity,
      child: Obx(() {
        if (frController.isProcessing.isTrue) {
          return bookLoadingShimmer();
        } else if (frController.freshReleaseBookList.isEmpty) {
          return Center(
            child: Text("No Books Available"),
          );
        } else if (frController.hasError.isTrue) {
          return bookLoadingShimmer();
        } else {
          return ListView.separated(
            controller: frController.listviewScrollController,
            itemCount: frController.isMoreDataAvailable.value
                ? frController.freshReleaseBookList.length + 1
                : frController.freshReleaseBookList.length,
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            separatorBuilder: (context, index) {
              return const Gap(22);
            },
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
                              frController
                                  .freshReleaseBookList[index].bookName),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Container(
                  width: 170,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(bottom: 26.0),
                  child: const ReusableCircularProgressIndicator(),
                );
              }
            },
          );
        }
      }),
    );
  }

  Widget bookLoadingShimmer() {
    return ListView.separated(
      itemCount: 12,
      scrollDirection: Axis.horizontal,
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      separatorBuilder: (context, index) {
        return const Gap(22);
      },
      itemBuilder: (context, index) {
        return SizedBox(
          width: 170,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
          ),
        );
      },
    );
  }
}
