import 'package:notespedia/utils/constants/app_export.dart';

class BookTitle18 extends StatelessWidget {
  const BookTitle18({
    super.key,
    required this.bookTitle,
    this.maxLines,
    this.overflow,
    this.fontSize,
  });

  final String bookTitle;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      bookTitle,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
    );
  }
}
