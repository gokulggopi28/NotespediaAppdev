import 'package:notespedia/utils/constants/app_export.dart';

class StaffToggleActionChip extends StatelessWidget {
  StaffToggleActionChip({
    super.key,
  });

  final stController = Get.find<StaffPublisherController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ActionChip(
        onPressed: () {
          staffSelectionBottomSheet(context);
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
                imageUrl:
                    "${stController.staffPublishersList[stController.selectedStaffPublisherIndex.value].staffImage}",
                fit: BoxFit.cover,
              ),
            ),
            const Gap(6),
            Text(
              HelperFunctions.capitalizeFirstLetter(stController
                  .staffPublishersList[
                      stController.selectedStaffPublisherIndex.value]
                  .staffName),
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
