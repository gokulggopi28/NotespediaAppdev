import 'package:notespedia/utils/constants/app_export.dart';

class BookIndicatorText10Widget extends StatelessWidget {
  const BookIndicatorText10Widget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Colors.grey,
            fontSize: 10,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w400,
          ),
    );
  }
}
