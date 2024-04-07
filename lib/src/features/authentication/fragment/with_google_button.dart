import 'package:notespedia/utils/constants/app_export.dart';

class WithGoogleButton extends StatelessWidget {
  const WithGoogleButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ReusableMaterialButton(
        height: 50,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(
            color: AppColors.greyBright,
            width: 1,
          ),
        ),
        onPressed: onPressed,
        padding: const EdgeInsets.only(
            left: 16.0, right: 16.0, top: 12.0, bottom: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.googleIcon,
              fit: BoxFit.contain,
            ),
            const Spacer(),
            Text(
              text,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
