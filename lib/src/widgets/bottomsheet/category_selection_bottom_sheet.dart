import 'package:notespedia/utils/constants/app_export.dart';

Future<dynamic> bookCategorySelectionBottomSheet(BuildContext context) {
  final nSController = Get.find<NetworkStateController>();
  final bcController = Get.find<BooksCategoryController>();

  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: false,
    enableDrag: true,
    isDismissible: true,
    elevation: 0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(26.0),
        topRight: Radius.circular(26.0),
      ),
    ),
    builder: (context) {
      return Container(
        height: 370,
        width: double.infinity,
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        child: Column(
          children: [
            const Gap(12),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Select Category",
                textAlign: TextAlign.center,
                maxLines: 1,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            const Gap(16),
            Divider(color: Colors.grey.shade200, height: 1.5),
            Expanded(
              child: Obx(() {
                return ListView.separated(
                  itemCount: bcController.booksCategoryList.length,
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.only(top: 16, bottom: 32),
                  physics: const ClampingScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return const Gap(8);
                  },
                  itemBuilder: (context, index) {
                    return Material(
                      color:
                          bcController.selectedBookCategoryIndex.value == index
                              ? Colors.green.shade50
                              : Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        splashColor: Colors.black.withOpacity(.1),
                        onTap: () async {
                          final selectedCategoryId =
                              bcController.booksCategoryList[index].categoryId;

                          if (nSController.isInternetConnected.isTrue) {
                            bcController.onCategorySelection(index);
                            final indexId = bcController
                                .findPositionByCategoryId(selectedCategoryId);
                            bcController.selectedBookCategoryIndex(indexId);
                          } else {
                            HelperFunctions.showSnackBar(
                              context: context,
                              message: "No Internet Connection",
                            );
                          }
                          Get.back();
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: double.maxFinite,
                            height: 55,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                ReusableCachedNetworkImage(
                                    imageUrl: bcController
                                        .booksCategoryList[index].categoryImg),
                                const Gap(6),
                                Text(
                                  bcController
                                      .booksCategoryList[index].categoryName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      );
    },
  );
}
