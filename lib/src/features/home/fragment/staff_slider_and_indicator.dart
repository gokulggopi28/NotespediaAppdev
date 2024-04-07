import 'package:notespedia/src/features/home/staff_based_books_screen.dart';
import 'package:notespedia/utils/constants/app_export.dart';

class StaffSliderAndIndicator extends StatelessWidget {
  StaffSliderAndIndicator({
    super.key,
  });

  // final stController = Get.put(StaffController());
  final nSController = Get.find<NetworkStateController>();
  final stController = Get.find<StaffPublisherController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          if (stController.isProcessing.isTrue) {
            return sliderLoadingShimmer();
          } else if (stController.staffPublishersList.isEmpty) {
            return Center(
              child: Text("No Authors Found"),
            );
          } else if (stController.hasError.isTrue) {
            return sliderLoadingShimmer();
          } else {
            return CarouselSlider.builder(
              itemCount: stController.staffPublishersList.length,
              carouselController: stController.carouselController,
              options: CarouselOptions(
                height: 125,
                autoPlay: false,
                padEnds: true,
                initialPage: 0,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                scrollPhysics: const ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                pauseAutoPlayOnTouch: true,
                pauseAutoPlayOnManualNavigate: true,
                pauseAutoPlayInFiniteScroll: true,
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                onPageChanged: (index, reason) {
                  stController.onCarouselPageChange(index);
                },
              ),
              itemBuilder: (context, index, pageViewIndex) {
                return AnimatedGestureDetector(
                  onTap: () async {
                    if (nSController.isInternetConnected.isTrue) {
                      //
                      final currentStaffId =
                          stController.staffPublishersList[index].staffId;
                      //
                      final positionId =
                          stController.findPositionByStaffId(currentStaffId);

                      stController.onStaffPublisherSelection(positionId);
                      stController.fetchBookByStaffId(currentStaffId);

                      Get.to(() => StaffBasedBooksScreen());
                    } else {}
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(
                          left: 24.0, right: 24.0, top: 12.0, bottom: 12.0),
                      decoration: const BoxDecoration(
                        color: AppColors.brightGreen,
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 75,
                            height: 75,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ReusableCachedNetworkImage(
                                imageUrl:
                                    "${stController.staffPublishersList[index].staffImage}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Gap(12),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  stController
                                      .staffPublishersList[index].staffName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                Text(
                                  stController.staffPublishersList[index]
                                      .staffDesignation,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        }),
        const Gap(8),
        // Align(
        //   alignment: Alignment.center,
        //   child: Obx(() {
        //     return AnimatedSmoothIndicator(
        //       count: 5,
        //       activeIndex: stController.currentSlider.value,
        //       axisDirection: Axis.horizontal,
        //       effect: const ScrollingDotsEffect(
        //         paintStyle: PaintingStyle.fill,
        //         activeDotColor: AppColors.brightGreen,
        //         dotColor: AppColors.dimGreen,
        //         activeDotScale: 1,
        //         dotHeight: 10,
        //         dotWidth: 10,
        //       ),
        //       onDotClicked: (index) {
        //         stController.carouselController.animateToPage(
        //           index,
        //           duration: const Duration(milliseconds: 200),
        //           curve: Curves.linearToEaseOut,
        //         );
        //       },
        //     );
        //   }),
        // ),
      ],
    );
  }

  Widget sliderLoadingShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: CarouselSlider.builder(
        itemCount: 5,
        options: CarouselOptions(
          height: 125,
          autoPlay: true,
          padEnds: true,
          initialPage: 0,
          aspectRatio: 16 / 9,
          viewportFraction: 0.8,
          scrollPhysics: const ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          pauseAutoPlayOnTouch: true,
          pauseAutoPlayOnManualNavigate: true,
          pauseAutoPlayInFiniteScroll: true,
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
        ),
        itemBuilder: (context, index, realIndex) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
