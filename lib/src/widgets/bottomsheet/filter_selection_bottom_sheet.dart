import 'package:notespedia/src/widgets/bottomsheet/expandable%20_list_item.dart';
import 'package:notespedia/utils/constants/app_export.dart';

import '../../features/home/controller/filter_controller.dart';
import '../../features/home/controller/new_fresh_released_controller.dart';

Future<dynamic> filterSelectionBottomSheet(BuildContext context) {
  final bcController = Get.find<BooksCategoryController>();
  final nfrController = Get.find<NewFreshReleaseController>();
  final stController = Get.find<StaffPublisherController>();
  final filterController = Get.put(FilterController(), permanent: true);

  RxSet<String> selectedCategories = filterController.selectedCategories;
  RxSet<String> selectedAuthors = filterController.selectedAuthors;
  RxSet<String> selectedPublications = <String>{}.obs;
  RxSet<String> selectedSortBy = <String>{}.obs;
  RxSet<String> selectedRatings = <String>{}.obs;
  RxSet<String> selectedFormats = <String>{}.obs;

  Widget createFilterChip(
      String label, String imageUrl, RxSet<String> selectedItems) {
    return Obx(() => FilterChip(
          label: Text(label),
          avatar: imageUrl.isNotEmpty
              ? CircleAvatar(backgroundImage: NetworkImage(imageUrl))
              : null,
          backgroundColor:
              selectedItems.contains(label) ? Colors.blue : Colors.white,
          selected: selectedItems.contains(label),
          onSelected: (bool selected) {
            if (selected) {
              selectedItems.add(label);
            } else {
              selectedItems.remove(label);
            }
          },
        ));
  }

  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: false,
    enableDrag: true,
    isDismissible: true,
    elevation: 0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(26.0),
        topRight: Radius.circular(26.0),
      ),
    ),
    builder: (context) {
      return Container(
        height: 370,
        width: double.infinity,
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        child: Column(children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Filter",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w500)),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Text("Close",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.grey, height: 1.5),

          // Filter Options
          Expanded(
            child: ListView(
              children: [
                ExpandableFilterItem(
                  title: "Categories",
                  contentBuilder: () => wrapContent(bcController
                      .booksCategoryList
                      .map((category) => createFilterChip(category.categoryName,
                          category.categoryImg, selectedCategories))
                      .toList()),
                ),
                ExpandableFilterItem(
                  title: "Author",
                  contentBuilder: () => wrapContent(stController
                      .staffPublishersList
                      .map((author) => createFilterChip(
                          author.staffName, author.staffImage, selectedAuthors))
                      .toList()),
                ),
                ExpandableFilterItem(
                  title: "Publication",
                  contentBuilder: () => wrapContent([
                    "Publication 1",
                    "Publication 2",
                    "Publication 3"
                  ]
                      .map((publication) => createFilterChip(
                          publication, '', selectedPublications))
                      .toList()),
                ),
                ExpandableFilterItem(
                  title: "Sort By",
                  contentBuilder: () => wrapContent([
                    "Bestselling",
                    "Publication Date",
                    "Price: High to Low",
                    "Price: Low to High"
                  ]
                      .map((sortOption) =>
                          createFilterChip(sortOption, '', selectedSortBy))
                      .toList()),
                ),
                ExpandableFilterItem(
                  title: "Rating",
                  contentBuilder: () => wrapContent([
                    "5.0",
                    "4.0 and above",
                    "3.0 and above",
                    "2.0 and above",
                    "1.0 and above"
                  ]
                      .map((rating) =>
                          createFilterChip(rating, '', selectedRatings))
                      .toList()),
                ),
                ExpandableFilterItem(
                  title: "Format",
                  contentBuilder: () => wrapContent(["Hard Copy", "Soft Copy"]
                      .map((format) =>
                          createFilterChip(format, '', selectedFormats))
                      .toList()),
                ),
              ],
            ),
          ),

          // Footer Row with Clear and Apply Buttons
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FilterChip(
                  label: Text("Clear Filters"),
                  onSelected: (bool selected) {
                    selectedCategories.clear();
                    selectedAuthors.clear();
                    selectedPublications.clear();
                    selectedSortBy.clear();
                    selectedRatings.clear();
                    selectedFormats.clear();
                  },
                ),
                FilterChip(
                  label: Text("Apply Filter"),
                  onSelected: (bool selected) {
                    nfrController.selectedAuthorIds.assignAll(stController
                        .staffPublishersList
                        .where((staff) =>
                            selectedAuthors.contains(staff.staffName))
                        .map((staff) => staff.staffId));

                    nfrController.selectedCategoryIds.assignAll(bcController
                        .booksCategoryList
                        .where((category) =>
                            selectedCategories.contains(category.categoryName))
                        .map((category) => category.categoryId));

                    Navigator.pop(context);
                    nfrController.fetchFreshReleaseBooks();
                  },
                ),
              ],
            ),
          ),
        ]),
      );
    },
  );
}

List<Widget> wrapContent(List<Widget> children) {
  return [
    Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Wrap(spacing: 8, runSpacing: 8, children: children),
    )
  ];
}
