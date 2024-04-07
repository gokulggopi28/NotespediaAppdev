import 'package:notespedia/utils/constants/app_export.dart';

class WithAppleButton extends StatelessWidget {
  const WithAppleButton({
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
        color: Colors.black,
        textColor: Colors.white,
        onPressed: onPressed,
        padding: const EdgeInsets.only(
            left: 16.0, right: 16.0, top: 12.0, bottom: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.appleIcon,
              fit: BoxFit.contain,
              color: Colors.white,
            ),
            const Spacer(),
            Text(
              text,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.white,
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
