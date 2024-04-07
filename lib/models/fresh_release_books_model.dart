// To parse this JSON data, do
//
//     final freshReleaseBookModel = freshReleaseBookModelFromJson(jsonString);

import 'dart:convert';

FreshReleaseBooksModel freshReleaseBookModelFromJson(String str) =>
    FreshReleaseBooksModel.fromJson(json.decode(str));

String freshReleaseBookModelToJson(FreshReleaseBooksModel data) =>
    json.encode(data.toJson());

class FreshReleaseBooksModel {
  final int totalItem;
  final dynamic nextPage;
  final dynamic previousPage;
  final List<FreshReleaseBookList> freshRelease;

  FreshReleaseBooksModel({
    required this.totalItem,
    required this.nextPage,
    required this.previousPage,
    required this.freshRelease,
  });

  factory FreshReleaseBooksModel.fromJson(Map<String, dynamic> json) =>
      FreshReleaseBooksModel(
        totalItem: json["count"],
        nextPage: json["next"],
        previousPage: json["previous"],
        freshRelease: List<FreshReleaseBookList>.from(
            json["results"].map((x) => FreshReleaseBookList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": totalItem,
        "next": nextPage,
        "previous": previousPage,
        "results": List<dynamic>.from(freshRelease.map((x) => x.toJson())),
      };
}

class FreshReleaseBookList {
  final int bookId;
  final String bookName;
  final String coverImage;
  final int publisherId;
  final int categoryId;
  final int courseId;
  final int authorId;

  FreshReleaseBookList({
    required this.bookId,
    required this.bookName,
    required this.coverImage,
    required this.publisherId,
    required this.categoryId,
    required this.courseId,
    required this.authorId,
  });

  factory FreshReleaseBookList.fromJson(Map<String, dynamic> json) =>
      FreshReleaseBookList(
        bookId: json["id"],
        bookName: json["name"],
        coverImage: json["cover_image"],
        publisherId: json["publisher_id"],
        categoryId: json["category_id"],
        courseId: json["course_id"],
        authorId: json["author_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": bookId,
        "name": bookName,
        "cover_image": coverImage,
        "publisher_id": publisherId,
        "category_id": categoryId,
        "course_id": courseId,
        "author_id": authorId,
      };
}
