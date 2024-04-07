import 'package:notespedia/src/features/search/fragment/result_not_found.dart';
import 'package:notespedia/utils/constants/app_export.dart';

import 'fragment/sliver_gridview_search_result.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final GlobalKey<ScaffoldState> searchScaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController searchScreenScrollController = ScrollController();
  final seController = Get.put(SearchScreenController());

  @override
  Widget build(BuildContext context) {
    final searchScreenController = Get.find<SearchScreenController>();
    return WillPopScope(
        onWillPop: () async {
          // Clear search data when back button is pressed
          searchScreenController.clearSearchData();
          return true; // Return true to allow the screen to be popped
        },
        child: Scaffold(
          key: searchScaffoldKey,
          body: Obx(() {
            return CustomScrollView(
              scrollDirection: Axis.vertical,
              controller: searchScreenScrollController,
              physics: const ClampingScrollPhysics(),
              slivers: [
                // Appbar Section
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  pinned: true,
                  stretch: true,
                  forceElevated: false,
                  backgroundColor: Colors.white,
                  surfaceTintColor: Colors.white,
                  foregroundColor: Colors.black,
                  shadowColor: Colors.black,
                  elevation: 0.5,
                  scrolledUnderElevation: 0.5,
                  toolbarHeight: 80,
                  titleSpacing: 0,
                  title: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: ReusableSearchBarFormField(
                      searchController: seController.searchTextController,
                      onChanged: (value) {
                        seController.fetchSearchResult(searchText: value);
                      },
                      onEditingComplete: () {
                        seController.fetchSearchResult(
                            searchText: seController.searchTextController.text);
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ),
                ),

                if (seController.searchTopCategoriesList.isEmpty &&
                    seController.searchTopPublishersList.isEmpty &&
                    seController.searchBooksList.isEmpty)
                  ResultNotFound()
                else
                  const SliverGap(24),
                Obx(() {
                  return SliverVisibility(
                    visible: seController.searchTopCategoriesList.isEmpty
                        ? false
                        : true,
                    sliver: const SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverToBoxAdapter(
                        child:
                            ReusableTitleWithoutButton(title: "Top Categories"),
                      ),
                    ),
                  );
                }),
                Obx(() {
                  return SliverVisibility(
                    visible: seController.searchTopCategoriesList.isEmpty
                        ? false
                        : true,
                    sliver: SliverToBoxAdapter(
                      child: ListviewTopCategories(),
                    ),
                  );
                }),

                // Top Publisher’s Section
                Obx(() {
                  return SliverGap(
                      seController.searchTopPublishersList.isEmpty ? 0 : 14);
                }),
                Obx(() {
                  return SliverVisibility(
                    visible: seController.searchTopPublishersList.isEmpty
                        ? false
                        : true,
                    sliver: const SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverToBoxAdapter(
                        child: ReusableTitleWithoutButton(
                            title: "Top Publisher’s"),
                      ),
                    ),
                  );
                }),
                Obx(() {
                  return SliverVisibility(
                    visible: seController.searchTopPublishersList.isEmpty
                        ? false
                        : true,
                    sliver: SliverToBoxAdapter(
                      child: ListviewTopPublishers(),
                    ),
                  );
                }),

                // Book List
                Obx(() {
                  return SliverGap(
                      seController.searchBooksList.isEmpty ? 0 : 14);
                }),
                Obx(() {
                  return SliverVisibility(
                    visible:
                        seController.searchBooksList.isEmpty ? false : true,
                    sliver: const SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverToBoxAdapter(
                        child:
                            ReusableTitleWithoutButton(title: "Search Result"),
                      ),
                    ),
                  );
                }),
                SliverGridviewSearchResult(),

                const SliverGap(32),
              ],
            );
          }),
        ));
  }
}
