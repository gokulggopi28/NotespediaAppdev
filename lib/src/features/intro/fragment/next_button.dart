import 'package:animate_do/animate_do.dart';
import 'package:notespedia/utils/constants/app_export.dart';

class NextButton extends StatelessWidget {
  NextButton({
    super.key,
  });

  final controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: const Duration(milliseconds: 1200),
      child: IconButton(
        onPressed: () {
          controller.nextPage();
        },
        iconSize: 32,
        icon: const RotatedBox(
          quarterTurns: 30,
          child: Icon(
            AppImages.backIcon,
            size: 32,
            color: AppColors.greyBrightIconColor,
          ),
        ),
      ),
    );
  }
}
