import 'package:notespedia/src/widgets/books/add_to_cart_outline_button.dart';
import 'package:notespedia/src/widgets/books/hard_and_soft_copy.dart';
import 'package:notespedia/utils/constants/app_export.dart';

import 'controller/expandable_list_controller.dart';

class StaffBooksDetailsScreen extends StatelessWidget {
  StaffBooksDetailsScreen({
    super.key,
    required this.bookDetailData,
  });

  final BookDetailData bookDetailData;

  final nSController = Get.find<NetworkStateController>();
  final bdController = Get.find<BooksDetailController>();
  final caController = Get.find<CartAndOrderController>();
  final controller = Get.put(ExpandableListController());
  final spController = Get.find<StaffPublisherController>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Check if it's possible to pop the current route.
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop(); // Pop the current route.
            return false; // Prevent the system from popping the route, as we've handled it manually.
          }
          return true; // Allow the system to handle the back button (e.g., exiting the app) if no routes to pop.
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: CustomScrollView(
            scrollDirection: Axis.vertical,
            controller: ScrollController(),
            physics: const ClampingScrollPhysics(),
            slivers: [
              // Appbar Section
              buildSliverAppBar(context),

              // Card Section
              const SliverGap(24),
              SliverToBoxAdapter(
                child: Center(
                  child: BookCard(
                    width: 190,
                    height: 280,
                    imageUrl: bookDetailData.bookCoverImage,
                  ),
                ),
              ),

              // Title Section
              const SliverGap(16),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                sliver: SliverToBoxAdapter(
                  child: BookTitle18(bookTitle: bookDetailData.bookName),
                ),
              ),

              // Author and Avatar Section
              const SliverGap(12),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                sliver: SliverToBoxAdapter(
                  child: AvatarAndName(
                    authorProfilePic: bookDetailData.authorImage,
                    authorName: bookDetailData.authorName,
                  ),
                ),
              ),

              // Info Header Section
              const SliverGap(16),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverToBoxAdapter(
                  child: BookInfoHeader(
                    totalReads: HelperFunctions.formatReadCount(
                        bookDetailData.bookReadCount),
                    rating: bookDetailData.bookRating,
                    totalChapters: bookDetailData.totalChapters,
                    totalPages: bookDetailData.totalPages,
                  ),
                ),
              ),

              // Tag Section
              const SliverGap(16),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverToBoxAdapter(
                  child: BookStatusInfo(instanceData: bookDetailData),
                ),
              ),

              SliverToBoxAdapter(
                child: ListviewTagChips(instanceData: bookDetailData),
              ),

              // Read more Section
              const SliverGap(16),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverToBoxAdapter(
                  child: ReusableReadMore(
                    text: bookDetailData.bookDescription,
                    maxLines: 2,
                  ),
                ),
              ),

              // Buy Section
              SliverVisibility(
                visible: bookDetailData.hasHardCopy == 1 ? true : false,
                sliver: const SliverGap(16),
              ),
              SliverVisibility(
                visible: bookDetailData.hasHardCopy == 1 ? true : false,
                sliver: SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: BookPurchaseButton(
                      controller: bookDetailData,
                      bookId: bookDetailData.bookId,
                    ),
                  ),
                ),
              ),

              // Add to cart Section
              SliverGap(bookDetailData.hasHardCopy == 1 ? 8 : 16),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverToBoxAdapter(
                  child: AddToCartOutlineButton(
                    selectedBookId: bookDetailData.bookId,
                  ),
                ),
              ),

              //
              const SliverGap(16),
              SliverVisibility(
                visible: bookDetailData.hasHardCopy == 1 ? false : true,
                sliver: SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: HardAndSoftCopy(instanceData: bookDetailData),
                  ),
                ),
              ),

              // Chapter Section
              Obx(() {
                return SliverGap(
                  bdController.bookChaptersList.isEmpty ? 0 : 16,
                );
              }),
              Obx(() {
                return SliverVisibility(
                  visible: bdController.bookChaptersList.isEmpty ? false : true,
                  sliver: SliverToBoxAdapter(
                    child: ChapterDetailsHeader(
                      totalChapters: bookDetailData.totalChapters,
                      seeAllOnPressed: () {},
                      downloadAllOnPressed: () {},
                    ),
                  ),
                );
              }),
              Obx(() {
                return SliverVisibility(
                  visible: bdController.bookChaptersList.isEmpty ? false : true,
                  sliver: ChapterInfoSliverList(),
                );
              }),
              Obx(() {
                return SliverVisibility(
                  visible: bdController.bookChaptersList.isEmpty ? false : true,
                  sliver: SliverToBoxAdapter(
                    child: GestureDetector(
                      onTap: () {
                        controller.isLoggedIn.toggle();
                      },
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(color: AppColors.greyDim),
                            // bottom: BorderSide(color: AppColors.greyDim),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Get subscription to read',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '28',
                                    style: TextStyle(
                                      color: Color(0xFF4EC9C7),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' chapters!',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),

              // Similar Books Section
              Obx(() {
                return SliverVisibility(
                  visible:
                      bdController.bookSuggestionList.isEmpty ? false : true,
                  sliver: const SliverGap(16),
                );
              }),
              Obx(() {
                return SliverVisibility(
                  visible:
                      bdController.bookSuggestionList.isEmpty ? false : true,
                  sliver: const SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverToBoxAdapter(
                      child: ReusableTitleWithoutButton(
                        title: "You may also like this",
                      ),
                    ),
                  ),
                );
              }),
              Obx(() {
                return SliverVisibility(
                  visible:
                      bdController.bookSuggestionList.isEmpty ? false : true,
                  sliver: SliverToBoxAdapter(child: ListviewSimilarBooks()),
                );
              }),

              // Author Suggestion Books Section
              Obx(() {
                return SliverGap(
                    bdController.authorRelatedBookList.isEmpty ? 0 : 16);
              }),
              Obx(() {
                print("Author Name: ${bookDetailData.authorName}");

                return SliverVisibility(
                  visible:
                      bdController.authorRelatedBookList.isEmpty ? false : true,
                  sliver: SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverToBoxAdapter(
                      child: ReusableTitleWithoutButton(
                        // Use string interpolation to dynamically set the title
                        title: "Read more from ${bookDetailData.authorName}",
                      ),
                    ),
                  ),
                );
              }),

              Obx(() {
                return SliverVisibility(
                  visible:
                      bdController.authorRelatedBookList.isEmpty ? false : true,
                  sliver: SliverToBoxAdapter(
                    child: ListviewAuthorSuggestionBooks(),
                  ),
                );
              }),

              //
              const SliverGap(24),
            ],
          ),
        ));
  }

  Widget buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      forceMaterialTransparency: true,
      floating: false,
      snap: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 60,
      titleSpacing: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          AppImages.backIcon,
          color: AppColors.greyBrightIconColor,
          size: 32,
        ),
      ),
      actions: [
        IconButton(
          enableFeedback: true,
          onPressed: () {},
          isSelected: false,
          icon: const Icon(
            AppImages.favouriteIcon,
            semanticLabel: AppTexts.favourite,
            color: AppColors.greyBrightIconColor,
            size: 28,
          ),
          selectedIcon: const Icon(
            AppImages.selectedFavIcon,
            semanticLabel: AppTexts.favourite,
            color: AppColors.greyBrightIconColor,
            size: 28,
          ),
        ),
        IconButton(
          onPressed: () {},
          isSelected: false,
          selectedIcon: const Icon(
            AppImages.selectedBookmarkIcon,
            semanticLabel: AppTexts.bookmark,
            color: AppColors.greyBrightIconColor,
            size: 28,
          ),
          icon: const Icon(
            AppImages.bookmarkIcon,
            semanticLabel: AppTexts.bookmark,
            color: AppColors.greyBrightIconColor,
            size: 28,
          ),
        ),
        IconButton(
          onPressed: () {},
          isSelected: false,
          selectedIcon: const Icon(
            AppImages.shareIcon,
            color: AppColors.greyBrightIconColor,
            size: 28,
          ),
          icon: const Icon(
            AppImages.shareIcon,
            color: AppColors.greyBrightIconColor,
            size: 28,
          ),
        ),
      ],
    );
  }
}
