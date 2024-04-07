import 'package:notespedia/utils/constants/app_export.dart';

class ListviewTopPublishers extends StatelessWidget {
  ListviewTopPublishers({
    super.key,
  });

  final seController = Get.put(SearchScreenController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (seController.isProcessing.isTrue) {
        return topPublishersLoadingShimmer();
      } else if (seController.hasError.isTrue) {
        return topPublishersLoadingShimmer();
      } else {
        return SizedBox(
          height: 120,
          width: double.infinity,
          child: ListView.separated(
            itemCount: seController.searchTopPublishersList.length,
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            separatorBuilder: (context, index) {
              return const Gap(22);
            },
            itemBuilder: (context, index) {
              return AnimatedGestureDetector(
                child: Container(
                  width: 120,
                  padding: const EdgeInsets.all(16),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shadows: [AppColors.containerShadow],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: ReusableCachedNetworkImage(
                      imageUrl: seController
                          .searchTopPublishersList[index].profileImage,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }
    });
  }

  Widget topPublishersLoadingShimmer() {
    return SizedBox(
      height: 120,
      width: double.infinity,
      child: ListView.separated(
        itemCount: 12,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        separatorBuilder: (context, index) {
          return const Gap(22);
        },
        itemBuilder: (context, index) {
          return SizedBox(
            width: 120,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
