import 'package:notespedia/utils/constants/app_export.dart';

class IconNameText extends StatelessWidget {
  const IconNameText({
    super.key,
    required this.icon,
    required this.iconName,
    required this.title,
    this.iconColor,
    this.size,
  });

  final IconData icon;
  final String iconName;
  final String title;
  final Color? iconColor;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.black,
              size: size ?? 18,
            ),
            const Gap(6),
            Text(
              iconName,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.black.withOpacity(.8),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ],
        ),
        const Gap(6),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
        ),
      ],
    );
  }
}
