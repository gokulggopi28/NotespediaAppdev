import 'package:notespedia/utils/constants/app_export.dart';

class ReusableTitleWithoutButton extends StatelessWidget {
  const ReusableTitleWithoutButton({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          maxLines: 1,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}
