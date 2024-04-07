import 'package:notespedia/utils/constants/app_export.dart';

class ReusableTitleAndIconButton extends StatelessWidget {
  const ReusableTitleAndIconButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              maxLines: 1,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            IconButton(
              onPressed: onPressed,
              style: IconButton.styleFrom(
                enableFeedback: true,
                padding: EdgeInsets.zero,
                alignment: Alignment.center,
                foregroundColor: AppColors.brightGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              icon: const RotatedBox(
                quarterTurns: 30,
                child: Icon(
                  AppImages.backIcon,
                  size: 30,
                  color: AppColors.brightGreen,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
