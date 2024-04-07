import 'package:notespedia/utils/constants/app_export.dart';

class ListviewCategoryBooks extends StatelessWidget {
  const ListviewCategoryBooks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 322,
      width: double.infinity,
      child: ListView.separated(
        itemCount: 12,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        separatorBuilder: (context, index) {
          return const Gap(22);
        },
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 170,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: BookCard(
                    imageUrl:
                        "https://content.wepik.com/statics/9032211/preview-page0.jpg",
                    onTap: () {
                      Get.toNamed("/bookDetails");
                    },
                  ),
                ),
                const Gap(6),
                const BookTitle14(title: "Book Name"),
              ],
            ),
          );
        },
      ),
    );
  }
}
