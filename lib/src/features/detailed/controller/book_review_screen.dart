import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;

import 'package:notespedia/models/books_review_model.dart';
import 'package:notespedia/repositories/user_preferences.dart';
import 'package:notespedia/src/widgets/books/avatar_and_name_review.dart';
import 'package:notespedia/utils/constants/app_export.dart';

class WriteReviewScreen extends StatefulWidget {
  final BookDetailData bookDetailData;
  final ReviewData? editingReview;
  final int currentRating;
  WriteReviewScreen({
    Key? key,
    required this.bookDetailData,
    this.editingReview,
    this.currentRating = 0,
  }) : super(key: key);

  @override
  _WriteReviewScreenState createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  late int currentRating;
  late TextEditingController _reviewController;
  int currentCharacterCount = 0;
  final int maxCharacterCount = 100;
  final ctController = Get.find<BooksCategoryController>();
  final nSController = Get.find<NetworkStateController>();

  @override
  void initState() {
    super.initState();
    if (widget.editingReview != null) {
      print("Editing review with initial rating: ${widget.currentRating}");
      currentRating = widget.currentRating;
      _reviewController =
          TextEditingController(text: widget.editingReview!.reviewText);
    } else {
      currentRating = 0;
      _reviewController = TextEditingController();
    }

    _reviewController.addListener(_updateCharacterCount);
  }

  void _updateCharacterCount() {
    setState(() {
      currentCharacterCount = _reviewController.text.length;
    });
  }

  Future<void> submitReview() async {
    final bookId = widget.bookDetailData.bookId;
    final userId = UserPreferences
        .userId; // Ensure you have a getter for userId in UserPreferences
    final rating = currentRating.toDouble();
    final reviewText = _reviewController.text.trim();

    if (reviewText.isEmpty) {
      // Show a message to the user that review text is empty
      HelperFunctions.showTopSnackBar(
        context: context,
        title: "Error",
        message: "Review text cannot be empty.",
      );
      return;
    }

    final reviewData = {
      "rating": rating.toString(),
      "review_text": reviewText,
      "book_id": bookId,
      "user_id": userId
    };

    try {
      String url;
      // Determine if editing an existing review or posting a new one
      if (widget.editingReview != null) {
        // URL for editing a review
        url =
            "${ApiConstants.baseUrl}books/review/${widget.editingReview!.id}/";
      } else {
        // URL for posting a new review
        url = "${ApiConstants.baseUrl}books/review/";
      }

      // Printing the URL and data being sent to the API
      print("URL: $url");
      print("Data being sent: $reviewData");

      dio.Response response = await dio.Dio().request(
        url,
        data: reviewData,
        options:
            dio.Options(method: widget.editingReview != null ? "PUT" : "POST"),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        HelperFunctions.showTopSnackBar(
          context: context,
          title: "Success",
          message: widget.editingReview != null
              ? "Review updated successfully."
              : "Review posted successfully.",
        );
        Get.toNamed(AppRoutes.homeRoute);
      } else {
        // Handle non-successful status codes
        HelperFunctions.showTopSnackBar(
          context: context,
          title: "Error",
          message: "Something went wrong. Please try again.",
        );
      }
    } catch (e) {
      print("Error making request: $e");
      if (e is dio.DioError) {
        print("Dio error: ${e.response?.statusCode}");
        print("Dio error response data: ${e.response?.data}");
      }
      HelperFunctions.showTopSnackBar(
        context: context,
        title: "Error",
        message: "Failed to post the review. Please try again later.",
      );
    }
  }

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
          appBar: AppBar(
            title: Text("Write a Review"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BookCard(
                      width: 104,
                      height: 180,
                      imageUrl: widget.bookDetailData.bookCoverImage,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.bookDetailData.bookName,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          AvatarAndNameReview(
                            authorProfilePic: widget.bookDetailData.authorImage,
                            authorName: widget.bookDetailData.authorName,
                          ),
                          SizedBox(height: 8),
                          StarRating(
                            initialRating: currentRating,
                            onRatingChanged: (rating) {
                              setState(() {
                                currentRating = rating;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                TextField(
                  controller: _reviewController,
                  maxLength: maxCharacterCount,
                  decoration: InputDecoration(
                    hintText: 'Describe your experience',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide(
                        color: Color(0xFFAAAAAA80),
                        width: 1,
                      ),
                    ),
                    counterText:
                        '${currentCharacterCount.toString()}/$maxCharacterCount',
                  ),
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  onChanged: (text) => _updateCharacterCount(),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: submitReview,
                  child: Text('Submit Review'),
                ),
              ],
            ),
          ),
        ));
  }
}

class StarRating extends StatefulWidget {
  final int initialRating;
  final ValueChanged<int> onRatingChanged;

  const StarRating({
    Key? key,
    required this.initialRating,
    required this.onRatingChanged,
  }) : super(key: key);

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  late int _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
    print("StarRating initialized with rating: $_currentRating");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < _currentRating ? Icons.star : Icons.star_border,
            color: index < _currentRating ? Colors.green : Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _currentRating = index + 1;
            });
            widget.onRatingChanged(_currentRating);
          },
        );
      }),
    );
  }
}
