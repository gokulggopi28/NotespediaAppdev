import 'package:notespedia/utils/constants/app_export.dart';

class BookStatusInfo extends StatelessWidget {
  const BookStatusInfo({
    super.key,
    required this.instanceData,
  });

  final BookDetailData instanceData;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 4,
      spacing: 8,
      crossAxisAlignment: WrapCrossAlignment.start,
      runAlignment: WrapAlignment.start,
      children: [
        Chip(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shadowColor: Colors.black,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          side: const BorderSide(
            width: 1,
            color: Color(0xFFD9D9D9),
            style: BorderStyle.solid,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          labelPadding: EdgeInsets.zero,
          label: Text(
            instanceData.status == 1
                ? 'Ongoing'
                : (instanceData.status == 2 ? "Complete" : "New updates"),
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: instanceData.status == 1
                      ? const Color(0xFFA5461C)
                      : (instanceData.status == 2
                          ? AppColors.brightGreen
                          : Colors.grey),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        Visibility(
          visible: instanceData.status == 1
              ? true
              : (instanceData.status == 2 ? false : true),
          child: Chip(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            shadowColor: Colors.black,
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            side: const BorderSide(
              width: 1,
              color: Color(0xFFD9D9D9),
              style: BorderStyle.solid,
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            labelPadding: const EdgeInsets.only(left: 3),
            avatar: const ReusableCompleteStatusIndicator(),
            label: Text(
              "${instanceData.newChapters} new chapter",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
