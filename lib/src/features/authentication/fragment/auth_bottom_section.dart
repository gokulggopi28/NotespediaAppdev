import 'package:notespedia/utils/constants/app_export.dart';

class AuthBottomSection extends StatelessWidget {
  const AuthBottomSection({
    super.key,
    required this.text,
    required this.navText,
    required this.onTap,
  });

  final String text;
  final String navText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: const Color(0xFF4B4B4B),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 0,
              ),
        ),
        const Gap(3),
        AnimatedGestureDetector(
          onTap: onTap,
          child: Text(
            navText,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: const Color(0xFF0033B7),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
          ),
        ),
      ],
    );
  }
}
