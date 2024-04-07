import 'package:notespedia/utils/constants/app_export.dart';

class TitleAndTextGrid extends StatelessWidget {
  const TitleAndTextGrid({
    super.key,
    required this.count,
    required this.title,
  });

  final String count;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          Text(
            count,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
          ),
          Text(
            title,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
          )
        ],
      ),
    );
  }
}
