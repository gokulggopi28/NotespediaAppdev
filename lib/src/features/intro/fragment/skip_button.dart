import 'package:animate_do/animate_do.dart';
import 'package:notespedia/utils/constants/app_export.dart';

class SkipButton extends StatelessWidget {
  SkipButton({
    super.key,
  });

  final controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 6,
      top: 0,
      child: FadeIn(
        duration: const Duration(milliseconds: 300),
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            "Skip",
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
          ),
          onPressed: () {
            controller.skipPage();
          },
        ),
      ),
    );
  }
}
