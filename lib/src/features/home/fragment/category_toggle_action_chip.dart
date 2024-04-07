import 'package:notespedia/utils/constants/app_export.dart';

import '../../../widgets/bottomsheet/category_selection_bottom_sheet.dart';

class CategoryToggleActionChip extends StatelessWidget {
  CategoryToggleActionChip({
    super.key,
  });

  final ctController = Get.find<BooksCategoryController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ActionChip(
        onPressed: () {
          bookCategorySelectionBottomSheet(context);
        },
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.only(left: 6, right: 6),
        labelPadding: const EdgeInsets.only(right: 6, top: 6, bottom: 6),
        side: BorderSide.none,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 30,
              height: 30,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
              ),
              child: ReusableCachedNetworkImage(
                imageUrl: ctController
                    .booksCategoryList[
                        ctController.selectedBookCategoryIndex.value]
                    .categoryImg,
                fit: BoxFit.cover,
              ),
            ),
            const Gap(6),
            Text(
              HelperFunctions.capitalizeFirstLetter(ctController
                  .booksCategoryList[
                      ctController.selectedBookCategoryIndex.value]
                  .categoryName),
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontSize: 14,
                    color: Colors.black.withOpacity(.8),
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Icon(
              AppImages.dropDownIcon,
              size: 26,
              color: AppColors.greyDimIconColor,
            ),
          ],
        ),
      );
    });
  }
}
