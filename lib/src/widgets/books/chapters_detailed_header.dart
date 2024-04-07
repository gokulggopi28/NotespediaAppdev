import 'package:notespedia/utils/constants/app_export.dart';

class ChapterDetailsHeader extends StatelessWidget {
  const ChapterDetailsHeader({
    super.key,
    required this.totalChapters,
    required this.seeAllOnPressed,
    required this.downloadAllOnPressed,
  });

  final int totalChapters;
  final VoidCallback seeAllOnPressed;
  final VoidCallback? downloadAllOnPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.only(
        top: 12,
        left: 16,
        right: 3,
        bottom: 6,
      ),
      child: Row(
        children: [
          const Icon(
            AppImages.chapterHeader,
            color: Colors.black,
            size: 26,
          ),
          const Gap(6),
          Text(
            "$totalChapters Chapters",
            maxLines: 1,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const Gap(16),
          const Spacer(),
          TextButton(
            onPressed: seeAllOnPressed,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.brightGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              "See all",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.brightGreen,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          TextButton(
            onPressed: downloadAllOnPressed,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.brightGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              "Download all",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.brightGreen,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
