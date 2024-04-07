import 'package:notespedia/utils/constants/app_export.dart';

class ReusableTitleAndTextButton extends StatelessWidget {
  const ReusableTitleAndTextButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.buttonText,
  });

  final String title;
  final String buttonText;
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
            TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                foregroundColor: const Color(0xff09cf64),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                buttonText,
                maxLines: 1,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: 18,
                      color: const Color(0xff09cf64),
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
