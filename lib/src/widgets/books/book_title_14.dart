import 'package:notespedia/utils/constants/app_export.dart';

class BookTitle14 extends StatelessWidget {
  const BookTitle14({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.overflow = TextOverflow.ellipsis,
    this.fontSize,
  });

  final String title;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: fontSize ?? 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
    );
  }
}
