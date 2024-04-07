import 'package:notespedia/src/widgets/books/icon_name_text.dart';
import 'package:notespedia/utils/constants/app_export.dart';

class BookInfoHeader extends StatelessWidget {
  const BookInfoHeader({
    super.key,
    required this.totalReads,
    required this.rating,
    required this.totalChapters,
    required this.totalPages,
  });

  final String totalReads;
  final String rating;
  final int totalChapters;
  final int totalPages;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconNameText(
          icon: AppImages.readsIcon,
          iconName: "Reads",
          title: totalReads.toString(),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: ReusableVerticalBar(),
        ),
        IconNameText(
          icon: AppImages.ratingIcon,
          iconName: "Rating",
          title: rating.toString(),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: ReusableVerticalBar(),
        ),
        IconNameText(
          icon: AppImages.chaptersIcon,
          iconName: "Chapters",
          title: totalChapters.toString(),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: ReusableVerticalBar(),
        ),
        IconNameText(
          icon: AppImages.pagesIcon,
          iconName: "Pages",
          title: totalPages.toString(),
        ),
      ],
    );
  }
}
