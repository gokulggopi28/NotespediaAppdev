import 'package:notespedia/utils/constants/app_export.dart';

class ButtonWithTextAndPrice extends StatelessWidget {
  const ButtonWithTextAndPrice({
    super.key,
    required this.title,
    required this.price,
    required this.onPressed,
  });

  final String title;
  final double price;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.only(top: 6, bottom: 6, left: 8, right: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        side: const BorderSide(width: 1, color: AppColors.brightGreen),
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
          ),
          Text(
            "₹ $price",
            textAlign: TextAlign.center,
            maxLines: 1,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
