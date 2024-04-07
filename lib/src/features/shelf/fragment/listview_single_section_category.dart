import 'package:notespedia/utils/constants/app_export.dart';

class ListviewSingleSectionCategory extends StatelessWidget {
  const ListviewSingleSectionCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> actionText = [
      "All",
      "Category 1",
      "Category 2",
      "Category 3",
      "Category 4",
      "Category 5",
      "Category 6",
      "Category 7",
      "Category 8"
    ];

    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ListView.separated(
        itemCount: actionText.length,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        separatorBuilder: (context, index) {
          return const Gap(16);
        },
        itemBuilder: (context, index) {
          DebugLogger.info("Shelf Categories Visible Index: $index");

          return ActionChip(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: .5,
            shadowColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            side: const BorderSide(
              width: 1,
              color: Color(0xFFD9D9D9),
              style: BorderStyle.solid,
            ),
            onPressed: () {},
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
            label: Text(
              actionText[index],
              maxLines: 1,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          );
        },
      ),
    );
  }
}
