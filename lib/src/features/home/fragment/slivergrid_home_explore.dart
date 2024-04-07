import 'package:notespedia/utils/constants/app_export.dart';

class SliverGridHomeExplore extends StatelessWidget {
  SliverGridHomeExplore({
    super.key,
  });

  // final exController = Get.put(ExplorerItemController());
  final nSController = Get.find<NetworkStateController>();
  final exController = Get.find<ExplorerItemController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (exController.isProcessing.isTrue &&
          exController.explorerItemList.isEmpty) {
        return categoryLoadingShimmer();
      } else if (exController.hasError.isTrue) {
        return categoryLoadingShimmer();
      } else {
        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
          sliver: SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisExtent: 110,
              maxCrossAxisExtent: 120,
              crossAxisSpacing: 22,
              mainAxisSpacing: 22,
            ),
            itemBuilder: (context, index) {
              return AnimatedGestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.exploreDetailedRoute);
                },
                child: Card(
                  color: Colors.white,
                  surfaceTintColor: Colors.white,
                  shadowColor: Colors.black,
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Container(
                    width: 120,
                    height: 120,
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.1),
                          blurRadius: 6,
                          offset: const Offset(1, 1),
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: ReusableCachedNetworkImage(
                              placeholderIndicatorEnable: false,
                              imageUrl: exController
                                  .explorerItemList[index].explorerImg,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                        ),
                        const Gap(6),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            exController.explorerItemList[index].explorerName,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Montserrat",
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: exController.explorerItemList.length,
          ),
        );
      }
    });
  }

  Widget categoryLoadingShimmer() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisExtent: 110,
          maxCrossAxisExtent: 120,
          crossAxisSpacing: 22,
          mainAxisSpacing: 22,
        ),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Card(
                color: Colors.white,
                surfaceTintColor: Colors.white,
                shadowColor: Colors.black,
                margin: EdgeInsets.zero,
                elevation: 0,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.1),
                        blurRadius: 6,
                        offset: const Offset(1, 1),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: 7,
      ),
    );
  }
}
