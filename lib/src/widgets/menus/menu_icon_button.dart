import 'package:notespedia/utils/constants/app_export.dart';

class MenuIconButton extends StatelessWidget {
  const MenuIconButton({
    super.key,
    required this.onPressed,
    required this.opacity,
  });

  final VoidCallback onPressed;
  final ValueNotifier<double> opacity;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity.value,
      duration: const Duration(milliseconds: 300),
      child: IgnorePointer(
        ignoring: opacity.value == 0.0,
        child: IconButton(
          onPressed: onPressed,
          padding: const EdgeInsets.all(8),
          enableFeedback: true,
          icon: Image.asset(
            semanticLabel: AppTexts.menu,
            AppImages.menu,
            height: 24,
            width: 24,
            isAntiAlias: true,
            color: AppColors.greyBrightIconColor,
            filterQuality: FilterQuality.high,
          ),
        ),
      ),
    );
  }
}
