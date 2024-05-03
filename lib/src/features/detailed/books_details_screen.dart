import 'package:dio/dio.dart';
import 'package:notespedia/src/widgets/books/add_to_cart_outline_button.dart';
import 'package:notespedia/src/widgets/books/hard_and_soft_copy.dart';
import 'package:notespedia/utils/constants/app_export.dart';
import 'package:badges/badges.dart' as badges;
import '../../../repositories/user_preferences.dart';
import '../home/controller/downloadandopenpdf.dart';
import '../home/controller/save_later_controller.dart';
import 'controller/book_review_screen.dart';
import 'controller/expandable_list_controller.dart';

class BooksDetailsScreen extends StatefulWidget {
  final BookDetailData bookDetailData;

  BooksDetailsScreen({Key? key, required this.bookDetailData})
      : super(key: key);

  @override
  _BooksDetailsScreenState createState() => _BooksDetailsScreenState();
}

class _BooksDetailsScreenState extends State<BooksDetailsScreen> {
  bool isBookSaved = false;
  final SaveForLaterBooksController _saveForLaterBooksController =
      Get.find<SaveForLaterBooksController>();
  final nSController = Get.find<NetworkStateController>();
  final bdController = Get.find<BooksDetailController>();
  final caController = Get.find<CartAndOrderController>();
  final controller = Get.put(ExpandableListController());
  final authController = Get.find<AuthenticationController>();
  @override
  void initState() {
    super.initState();
    _checkIfBookIsSaved();
  }

  void _checkIfBookIsSaved() {
    final userId = UserPreferences.userId;
    setState(() {
      isBookSaved = _saveForLaterBooksController.isBookSavedForLater(
          widget.bookDetailData.bookId, userId);
    });
  }

  Future<void> _saveBookForLater(int bookId, int userId) async {
    try {
      var response = await Dio().post(
        '${ApiConstants.baseUrl}/shelf/save_for_later/',
        data: {
          'book_id': bookId,
          'user_id': userId,
        },
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Book saved for later successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to save the book for later',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while saving the book for later',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _removeBookFromSavedForLater(int savedBookId) async {
    try {
      var response = await Dio().delete(
        '${ApiConstants.baseUrl}/shelf/save_for_later/$savedBookId/',
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Book removed from saved for later successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to remove book from saved for later',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while removing the book from saved for later',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _toggleSavedForLater() async {
    final userId = UserPreferences.userId;

    if (isBookSaved) {
      final SaveForLaterBook? savedBook =
          _saveForLaterBooksController.saveForLaterBooksList.firstWhereOrNull(
        (item) =>
            item.bookId == widget.bookDetailData.bookId &&
            item.userId == userId,
      );

      if (savedBook != null) {
        await _removeBookFromSavedForLater(savedBook.id);
        setState(() {
          isBookSaved = false;
        });
        _saveForLaterBooksController.fetchSaveForLaterBooks();
      }
    } else {
      await _saveBookForLater(widget.bookDetailData.bookId, userId);
      setState(() {
        isBookSaved = true;
      });
      _saveForLaterBooksController.fetchSaveForLaterBooks();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop(); // Pop the current route.
            return false;
          }
          return true;
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
                    imageUrl: widget.bookDetailData.bookCoverImage,
                  ),
                ),
              ),

              // Title Section
              const SliverGap(16),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                sliver: SliverToBoxAdapter(
                  child: BookTitle18(bookTitle: widget.bookDetailData.bookName),
                ),
              ),

              // Author and Avatar Section
              const SliverGap(12),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                sliver: SliverToBoxAdapter(
                  child: AvatarAndName(
                    authorProfilePic: widget.bookDetailData.authorImage,
                    authorName: widget.bookDetailData.authorName,
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
                        widget.bookDetailData.bookReadCount),
                    rating: widget.bookDetailData.bookRating,
                    totalChapters: widget.bookDetailData.totalChapters,
                    totalPages: widget.bookDetailData.totalPages,
                  ),
                ),
              ),

              // Tag Section
              const SliverGap(16),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverToBoxAdapter(
                  child: BookStatusInfo(instanceData: widget.bookDetailData),
                ),
              ),

              SliverToBoxAdapter(
                child: ListviewTagChips(instanceData: widget.bookDetailData),
              ),

              // Read more Section
              const SliverGap(16),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverToBoxAdapter(
                  child: ReusableReadMore(
                    text: widget.bookDetailData.bookDescription,
                    maxLines: 2,
                  ),
                ),
              ),

              // Buy Section
              // SliverVisibility(
              //   visible: bookDetailData.hasHardCopy == 1 ? true : false,
              //   sliver: const SliverGap(16),
              // ),
              SliverVisibility(
                visible: widget.bookDetailData.hasHardCopy == 1 ? true : false,
                sliver: SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: BookPurchaseButton(
                      controller: widget.bookDetailData,
                      bookId: widget.bookDetailData.bookId,
                    ),
                  ),
                ),
              ),

              // Add to cart Section
              SliverGap(widget.bookDetailData.hasHardCopy == 1 ? 8 : 16),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverToBoxAdapter(
                  child: AddToCartOutlineButton(
                    selectedBookId: widget.bookDetailData.bookId,
                  ),
                ),
              ),

              //
              const SliverGap(16),
              SliverVisibility(
                visible: widget.bookDetailData.hasHardCopy == 1 ? false : true,
                sliver: SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: BookPurchaseButton(
                      controller: widget.bookDetailData,
                      bookId: widget.bookDetailData.bookId,
                    ),
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
                      totalChapters: bdController.bookChaptersList.length,
                      seeAllOnPressed: () {},
                      downloadAllOnPressed: () async {
                        final BooksDetailController bdController =
                            Get.find<BooksDetailController>();
                        final Dio dio = Dio();
                        try {
                          String pdfUrl =
                              bdController.bookDetailData[0].fileurl;
                          int userId = UserPreferences.userId;
                          int bookId = bdController.bookDetailData[0].bookId;

                          final Map<String, dynamic> requestData = {
                            "user_id": userId,
                            "book_id": bookId,
                          };

                          print("Sending request data: $requestData");

                          final response = await dio.post(
                            "${ApiConstants.baseUrl}/shelf/download_book/",
                            data: requestData,
                          );

                          // Checking and printing the response
                          if (response.statusCode == 200) {
                            print(
                                "Response Data: ${response.data}"); // Printing the actual response data
                            print(
                                "Book download logged successfully."); // This confirms the log was successful
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Download Successfull")));
                            // Proceed to download and open the PDF
                            await downloadAndOpenMyPdf(context, pdfUrl, userId,
                                startPage: 0);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("${response.data}")));
                            print(
                                "Failed to log book download. Status Code: ${response.statusCode}, Response: ${response.data}");
                          }
                        } on DioError catch (dioError) {
                          // Here we specifically catch DioError to access the response data
                          if (dioError.response != null) {
                            // When the server sends a structured error response
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("${dioError.response?.data}")));
                            print("DioError: ${dioError.response?.data}");
                          } else {
                            // For other DioErrors without response data
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("${dioError.response?.data}")));
                            print(
                                "DioError without response data: ${dioError.message}");
                          }
                        } catch (e) {
                          print('Error during download log or opening PDF: $e');
                        }
                      },
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
              // Obx(() {
              //   final authController = Get.find<AuthenticationController>();
              //   return SliverVisibility(
              //     visible: authController.isLoggedIn.isFalse,
              //     sliver: SliverToBoxAdapter(
              //       child: GestureDetector(
              //         onTap: () => _handleTap(context),
              //         child: Container(
              //           height: 60,
              //           width: double.infinity,
              //           alignment: Alignment.center,
              //           padding: const EdgeInsets.all(8.0),
              //           decoration: const BoxDecoration(
              //             color: Colors.white,
              //             border: Border(
              //               top: BorderSide(color: AppColors.greyDim),
              //               bottom: BorderSide(color: AppColors.greyDim),
              //             ),
              //           ),
              //           child: const Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Text.rich(
              //                 TextSpan(
              //                   children: [
              //                     TextSpan(
              //                       text: 'Login to see ',
              //                       style: TextStyle(
              //                         color: Colors.black,
              //                         fontSize: 14,
              //                         fontWeight: FontWeight.w500,
              //                         height: 0,
              //                       ),
              //                     ),
              //                     TextSpan(
              //                       text: ' ',
              //                       style: TextStyle(
              //                         color: Colors.white,
              //                         fontSize: 14,
              //                         fontWeight: FontWeight.w500,
              //                         height: 0,
              //                       ),
              //                     ),
              //                     TextSpan(
              //                       text: 'All',
              //                       style: TextStyle(
              //                         color: Color(0xFF4EC9C7),
              //                         fontSize: 14,
              //                         fontWeight: FontWeight.w500,
              //                         height: 0,
              //                       ),
              //                     ),
              //                     TextSpan(
              //                       text: ' chapters!',
              //                       style: TextStyle(
              //                         color: Colors.black,
              //                         fontSize: 14,
              //                         fontWeight: FontWeight.w500,
              //                         height: 0,
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //   );
              // }),

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
                return SliverVisibility(
                  visible:
                      bdController.authorRelatedBookList.isEmpty ? false : true,
                  sliver: SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverToBoxAdapter(
                      child: ReusableTitleWithoutButton(
                        title:
                            "Read more from ${widget.bookDetailData.authorName}",
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
              if (authController.isLoggedIn.isTrue)
                buildRatingAndReviewSection(),
              if (authController.isLoggedIn.isTrue)
                buildUserReviewSection(context),
              const SliverGap(24),
            ],
          ),
        ));
  }

  Widget buildRatingAndReviewSection() {
    double totalRating = 0.0;
    if (bdController.bookReviewList.isNotEmpty) {
      for (var review in bdController.bookReviewList) {
        totalRating += double.tryParse(review.rating!) ?? 0.0;
      }
      double averageRating = totalRating / bdController.bookReviewList.length;

      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableTitleWithoutButton(title: "Rating and Reviews"),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    averageRating.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${bdController.bookReviewList.length} reviews',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          double starRating = averageRating - index;
                          Color starColor =
                              starRating >= 1 ? Colors.green : Colors.grey;
                          if (starRating < 1 && starRating > 0) {
                            return Icon(Icons.star_half,
                                color: starColor, size: 14.09);
                          } else if (starRating >= 1) {
                            return Icon(Icons.star,
                                color: starColor, size: 14.09);
                          } else {
                            return Icon(Icons.star_border,
                                color: starColor, size: 14.09);
                          }
                        }),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => WriteReviewScreen(
                          bookDetailData: widget.bookDetailData));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF05CF64),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    child: Text(
                      "Write a review",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableTitleWithoutButton(title: "Rating and Reviews"),
              SizedBox(height: 8),
              buildNoReviewsRow(),
            ],
          ),
        ),
      );
    }
  }

  Widget buildNoReviewsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'No Reviews Yet',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Get.to(
                () => WriteReviewScreen(bookDetailData: widget.bookDetailData));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF05CF64),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: Text(
            "Write a review",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildUserReviewSection(BuildContext context) {
    final reviewList = bdController.bookReviewList;
    void showDeleteConfirmationDialog(BuildContext context, int reviewIndex,
        BooksDetailController bdController) {
      final reviewId = bdController.bookReviewList[reviewIndex]
          .id; // Assuming each review has an 'id' field

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Delete Review"),
            content: Text("Are you sure you want to delete your review?"),
            actions: <Widget>[
              TextButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
              TextButton(
                child: Text("Yes"),
                onPressed: () async {
                  await bdController
                      .deleteReview(reviewId); // Call the deletion method
                  Navigator.of(context).pop(); // Close the dialog
                  // Optionally refresh your reviews list or UI here
                  bdController.fetchBookReviewDetails(bdController
                      .bookDetailData
                      .first
                      .bookId); // Assuming you have a method to refresh the reviews
                },
              ),
            ],
          );
        },
      );
    }

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: reviewList.length,
          itemBuilder: (context, index) {
            final review = reviewList[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // User info and review content
                    Expanded(
                      child: Row(
                        children: [
                          // Circular ImageView
                          Container(
                            width: 29,
                            height: 29,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(review.profileImage ??
                                    'https://via.placeholder.com/150'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          SizedBox(width: 16),
                          // User Name
                          Text(
                            review.userName ??
                                'Anonymous', // Provide a default name
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),

                    PopupMenuButton<String>(
                      onSelected: (String result) async {
                        if (result == 'edit') {
                          // Extract and round the rating when passing it to the editing screen
                          double extractedRating = double.tryParse(
                                  reviewList[index].rating ?? '0.0') ??
                              0.0;
                          int roundedRating = extractedRating.round();
                          print(
                              "Extracted double rating for editing: $extractedRating");
                          print(
                              "Extracted rounded rating for editing: $roundedRating");
                          var result = await Get.to(() => WriteReviewScreen(
                                bookDetailData: widget.bookDetailData,
                                editingReview: reviewList[index],
                                currentRating: roundedRating,
                              ));

                          print(
                              "Extracted double rating for editing: $extractedRating");
                        } else if (result == 'delete') {
                          showDeleteConfirmationDialog(
                              context, index, bdController);
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'edit',
                          child: Text('Edit'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'delete',
                          child: Text('Delete'),
                        ),
                      ],
                      icon: Icon(Icons.more_vert, color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 8),

                // Review stars and duration
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Five stars
                    Row(
                      children: buildStarIcons(review
                          .rating!), // Assume this method exists to build star icons based on rating
                    ),
                    SizedBox(width: 16),
                    // Text "2 hours ago"
                    Text(
                      review.durationSinceUploaded!,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),

                // Review text
                Text(
                  review.reviewText!,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    height: 1.21,
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey,
            thickness: 0.2,
            height: 16,
          ),
        ),
      ),
    );
  }

  Widget buildSliverAppBar(BuildContext context) {
    final caController = Get.find<
        CartAndOrderController>(); // Ensure you have this line if caController is not globally declared in this widget
    final BooksDetailController bddcontroller =
        Get.find<BooksDetailController>();
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
        // IconButton(
        //   enableFeedback: true,
        //   onPressed: () {},
        //   icon: const Icon(
        //     AppImages.favouriteIcon,
        //     semanticLabel: AppTexts.favourite,
        //     color: AppColors.greyBrightIconColor,
        //     size: 28,
        //   ),
        // ),
        IconButton(
          icon: Icon(isBookSaved ? Icons.bookmark : Icons.bookmark_border),
          onPressed: _toggleSavedForLater,
        ),
        // IconButton(
        //   onPressed: () {},
        //   icon: const Icon(
        //     AppImages.shareIcon,
        //     color: AppColors.greyBrightIconColor,
        //     size: 28,
        //   ),
        // ),
        // Added Cart Icon Button with Badge
        IconButton(
          onPressed: () {
            Get.toNamed("/cart");
          },
          icon: badges.Badge(
            showBadge: caController.cartItemList.length.toString() == "0"
                ? false
                : true,
            badgeContent: Text(
              caController.cartItemList.length.toString(),
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
            badgeStyle: badges.BadgeStyle(badgeColor: AppColors.badgeIconColor),
            position: badges.BadgePosition.custom(top: -7, end: -7),
            child: const Icon(
              AppImages.cartIcon,
              color: AppColors.greyBrightIconColor,
              size: 26,
              semanticLabel: AppTexts.cart,
            ),
          ),
        ),
      ],
    );
  }

  void _handleTap(BuildContext ctx) {
    if (authController.isLoggedIn.isFalse &&
        authController.isUserId.value == 0) {
      HelperFunctions.showTopSnackBar(
        context: ctx,
        title: "Status Message",
        message: "Please Login",
      );

      Get.toNamed(AppRoutes.signInMobileRoute);
    } else {
      controller.isLoggedIn.toggle();
    }
  }

  List<Widget> buildStarIcons(String ratingString) {
    double rating = double.tryParse(ratingString) ?? 0.0;
    int fullStars = rating.floor();
    bool hasHalfStar = rating - fullStars >= 0.5;

    return List<Widget>.generate(5, (index) {
      if (index < fullStars) {
        return Icon(Icons.star, color: Color(0xFF05CF64), size: 14.09);
      } else if (index == fullStars && hasHalfStar) {
        return Icon(Icons.star_half, color: Color(0xFF05CF64), size: 14.09);
      } else {
        return Icon(Icons.star_border, color: Color(0xFF05CF64), size: 14.09);
      }
    });
  }
}
