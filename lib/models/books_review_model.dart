// To parse this JSON data, do
//
//     final reviewResponse = reviewResponseFromJson(jsonString);

import 'dart:convert';

ReviewResponse reviewResponseFromJson(String str) =>
    ReviewResponse.fromJson(json.decode(str));

String reviewResponseToJson(ReviewResponse data) => json.encode(data.toJson());

class ReviewResponse {
  ReviewResponse({
    required this.data,
  });

  final List<ReviewData> data;

  factory ReviewResponse.fromJson(Map<String, dynamic> json) => ReviewResponse(
        data: List<ReviewData>.from(
            json["data"].map((x) => ReviewData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ReviewData {
  final int id;
  final int bookId;
  final int userId;
  final String? rating; // Made nullable
  final String? reviewText; // Made nullable
  final String? durationSinceUploaded; // Made nullable
  final String? userName; // Made nullable
  final String? profileImage; // Made nullable

  ReviewData({
    required this.id,
    required this.bookId,
    required this.userId,
    this.rating,
    this.reviewText,
    this.durationSinceUploaded,
    this.userName,
    this.profileImage,
  });

  factory ReviewData.fromJson(Map<String, dynamic> json) => ReviewData(
        id: json["id"],
        bookId: json["book_id"],
        userId: json["user_id"],
        rating:
            json["rating"] as String?, // Using `as String?` for nullable fields
        reviewText: json["review_text"] as String?,
        durationSinceUploaded: json["duration_since_uploaded"] as String?,
        userName: json["user_name"] as String?,
        profileImage: json["profile_image"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "book_id": bookId,
        "user_id": userId,
        "rating": rating,
        "review_text": reviewText,
        "duration_since_uploaded": durationSinceUploaded,
        "user_name": userName,
        "profile_image": profileImage,
      };
}
