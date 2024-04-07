import 'package:notespedia/utils/constants/app_export.dart';

class ListviewCircularStories extends StatelessWidget {
  ListviewCircularStories({
    super.key,
  });

  final nSController = Get.find<NetworkStateController>();
  final csController = Get.find<CircularStoryController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      width: double.infinity,
      child: Obx(() {
        if (csController.isProcessing.isTrue) {
          return storyLoadingShimmer();
        } else if (csController.circularStoryList.isEmpty) {
          return Center(
            child: Text("No Stories Available"),
          );
        } else if (csController.hasError.isTrue) {
          return storyLoadingShimmer();
        } else {
          return ListView.separated(
            itemCount: csController.circularStoryList.length,
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
            separatorBuilder: (context, index) {
              return const Gap(22);
            },
            itemBuilder: (context, index) {
              return SizedBox(
                width: 85,
                child: Column(
                  children: [
                    Expanded(
                      child: AnimatedGestureDetector(
                        end: 0.96,
                        onTap: () async {
                          final url =
                              csController.circularStoryList[index].routingUrl;

                          if (nSController.isInternetConnected.isTrue) {
                            await HelperFunctions.launchUrl(url);
                            await Future.delayed(
                                const Duration(milliseconds: 600));
                            csController.markAsVisited(index);
                          } else {
                            HelperFunctions.showSnackBar(
                              context: context,
                              message: "No internet Connection",
                            );
                          }
                        },
                        child: Obx(
                          () {
                            final isVisited = csController.visitedStoryIndices
                                .contains(index);

                            return Container(
                              width: 85,
                              height: 85,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 2,
                                  color: isVisited
                                      ? AppColors.dimGreen
                                      : AppColors.brightGreen,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  shape: BoxShape.circle,
                                ),
                                child: ReusableCachedNetworkImage(
                                  imageUrl: csController
                                      .circularStoryList[index].image,
                                  fit: BoxFit.cover,
                                  maxHeightDiskCache: 1024,
                                  maxWidthDiskCache: 1024,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const Gap(6),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        csController.circularStoryList[index].title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade600,
                                ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }

  Widget storyLoadingShimmer() {
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
          width: 85,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: 85,
                    height: 85,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Gap(6),
                Container(
                  height: 8,
                  width: double.maxFinite,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
