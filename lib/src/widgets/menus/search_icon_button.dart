import 'package:notespedia/utils/constants/app_export.dart';

class SearchIconButton extends StatelessWidget {
  const SearchIconButton({
    super.key,
    required this.opacity,
  });

  final ValueNotifier<double> opacity;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity.value,
      duration: const Duration(milliseconds: 300),
      child: IgnorePointer(
        ignoring: opacity.value == 0.0,
        child: IconButton(
          padding: const EdgeInsets.all(8),
          enableFeedback: true,
          onPressed: () {
            Get.toNamed(AppRoutes.searchRoute);
          },
          icon: const Icon(
            AppImages.searchIcon,
            color: AppColors.greyBrightIconColor,
            size: 26,
            semanticLabel: AppTexts.search,
          ),
        ),
      ),
    );
  }
}
