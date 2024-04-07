import 'package:notespedia/src/features/home/categories_based_books_screen.dart';
import 'package:notespedia/utils/constants/app_export.dart';

class MultiSectionCategories extends StatelessWidget {
  MultiSectionCategories({
    super.key,
  });

  final nSController = Get.find<NetworkStateController>();
  final caController = Get.find<BooksCategoryController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 135,
      width: double.infinity,
      child: Obx(() {
        if (caController.isProcessing.isTrue) {
          return categoryLoadingShimmer();
        } else if (caController.hasError.isTrue) {
          return categoryLoadingShimmer();
        } else if (caController.booksCategoryList.isEmpty) {
          return Center(
            child: Text("Category Not Found"),
          );
        } else {
          final listLength = caController.booksCategoryList.length;
          final divideListLength = (listLength / 2).ceil();
          final firstList =
              caController.booksCategoryList.sublist(0, divideListLength);
          final secondList =
              caController.booksCategoryList.sublist(divideListLength);

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCategoryRow(context, firstList),
                const Gap(8),
                _buildCategoryRow(context, secondList),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _buildCategoryRow(
      BuildContext context, List<BookCategoryModel> categories) {
    return Container(
      height: 55,
      alignment: Alignment.centerLeft,
      child: ListView.separated(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return const Gap(12);
        },
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              boxShadow: [AppColors.dimContainerShadow],
            ),
            child: ActionChip(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              elevation: 0,
              pressElevation: 3,
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 10.0, bottom: 10.0),
              shadowColor: const Color(0xff8a959e).withOpacity(.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              side: BorderSide.none,
              avatar: SizedBox(
                height: 28,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: ReusableCachedNetworkImage(
                    imageUrl: categories[index].categoryImg,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
              label: Container(
                height: 30,
                alignment: Alignment.center,
                child: Text(
                  categories[index].categoryName,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
              onPressed: () {
                final selectedCategoryId = categories[index].categoryId;
                if (nSController.isInternetConnected.isTrue) {
                  caController.onCategorySelection(selectedCategoryId);
                } else {
                  HelperFunctions.showSnackBar(
                      context: context, message: "No Internet Connection");
                }
                Get.to(() => CategoryBasedBooksScreen());
              },
            ),
          );
        },
      ),
    );
  }

  Widget categoryLoadingShimmer() {
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
          width: 140,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: 140,
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 10.0, bottom: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const Gap(8),
                Expanded(
                  child: Container(
                    width: 140,
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 10.0, bottom: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
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
