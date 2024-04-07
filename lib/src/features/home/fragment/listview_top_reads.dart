import 'package:notespedia/utils/constants/app_export.dart';

class ListviewTopReads extends StatelessWidget {
  ListviewTopReads({
    super.key,
  });

  // final trController = Get.put(TopReadsController());
  final nSController = Get.find<NetworkStateController>();
  final trController = Get.find<TopReadsController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      width: double.infinity,
      child: Obx(() {
        if (trController.isProcessing.isTrue &&
            trController.topReadBookList.isEmpty) {
          return topReadsLoadingShimmer();
        } else if (trController.hasError.isTrue) {
          return topReadsLoadingShimmer();
        } else if (trController.topReadBookList.isEmpty) {
          // Shows "No Data Available" when the list is empty
          return Center(child: Text('No Data Available'));
        } else {
          return ListView.separated(
            controller: trController.listviewScrollController,
            itemCount: trController.isMoreDataAvailable.value
                ? trController.topReadBookList.length + 1
                : trController.topReadBookList.length,
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
            separatorBuilder: (BuildContext context, int index) {
              return const Gap(16);
            },
            itemBuilder: (context, index) {
              if (index < trController.topReadBookList.length) {
                return AnimatedGestureDetector(
                  onTap: () async {
                    final currentBookId =
                        trController.topReadBookList[index].bookId;
                    if (nSController.isInternetConnected.isTrue) {
                      await trController.fetchBookDetails(currentBookId);
                      var bookDetailController =
                          trController.topReadBooksDetailList.firstWhere(
                              (detail) => detail.bookId == currentBookId);
                      Get.to(
                        () => BooksDetailsScreen(
                          bookDetailData: bookDetailController,
                        ),
                      );
                    } else {}
                  },
                  child: Card(
                    margin: EdgeInsets.zero,
                    color: AppColors.dimGreen,
                    surfaceTintColor: AppColors.dimGreen,
                    elevation: 0.5,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0)),
                      side: BorderSide(
                        color: AppColors.brightGreen.withOpacity(.5),
                        width: 1.5,
                      ),
                    ),
                    child: Container(
                      width: 220,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  FlexStringExtensions(trController
                                          .topReadBookList[index].bookName)
                                      .capitalize,
                                  maxLines: 2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                Text(
                                  "Field Data",
                                  maxLines: 2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: Colors.grey,
                                        fontSize: 10,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    Image.asset(
                                      AppImages.readersIcon,
                                      width: 18,
                                      height: 18,
                                      fit: BoxFit.contain,
                                      color: Colors.yellow.shade800,
                                      isAntiAlias: true,
                                      filterQuality: FilterQuality.high,
                                      colorBlendMode: BlendMode.srcIn,
                                    ),
                                    const Gap(1),
                                    Expanded(
                                      child: Text(
                                        "${trController.topReadBookList[index].readsCount} Readers",
                                        maxLines: 1,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              color: Colors.yellow.shade800,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Container(
                              width: 65,
                              height: double.maxFinite,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: ReusableCachedNetworkImage(
                                imageUrl: trController
                                    .topReadBookList[index].coverImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
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

  Widget topReadsLoadingShimmer() {
    return ListView.separated(
      itemCount: 12,
      scrollDirection: Axis.horizontal,
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      separatorBuilder: (context, index) {
        return const Gap(16);
      },
      itemBuilder: (context, index) {
        return SizedBox(
          width: 220,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
