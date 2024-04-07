import 'package:notespedia/utils/constants/app_export.dart';

class ReusableSliverIconAppBar extends StatelessWidget {
  const ReusableSliverIconAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      forceMaterialTransparency: true,
      floating: true,
      snap: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 60,
      titleSpacing: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          AppImages.backIcon,
          color: AppColors.greyBrightIconColor,
          size: 32,
        ),
      ),
      actions: [
        IconButton(
          enableFeedback: true,
          onPressed: () {},
          isSelected: false,
          icon: const Icon(
            AppImages.favouriteIcon,
            semanticLabel: AppTexts.favourite,
            color: AppColors.greyBrightIconColor,
            size: 28,
          ),
          selectedIcon: const Icon(
            AppImages.selectedFavIcon,
            semanticLabel: AppTexts.favourite,
            color: AppColors.greyBrightIconColor,
            size: 28,
          ),
        ),
        IconButton(
          onPressed: () {},
          isSelected: false,
          selectedIcon: const Icon(
            AppImages.selectedBookmarkIcon,
            semanticLabel: AppTexts.bookmark,
            color: AppColors.greyBrightIconColor,
            size: 28,
          ),
          icon: const Icon(
            AppImages.bookmarkIcon,
            semanticLabel: AppTexts.bookmark,
            color: AppColors.greyBrightIconColor,
            size: 28,
          ),
        ),
        IconButton(
          onPressed: () {},
          isSelected: false,
          selectedIcon: const Icon(
            AppImages.shareIcon,
            color: AppColors.greyBrightIconColor,
            size: 28,
          ),
          icon: const Icon(
            AppImages.shareIcon,
            color: AppColors.greyBrightIconColor,
            size: 28,
          ),
        ),
      ],
    );
  }
}
