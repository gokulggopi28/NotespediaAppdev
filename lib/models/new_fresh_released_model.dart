// To parse this JSON data, do
//
//     final freshReleaseBookModel = freshReleaseBookModelFromJson(jsonString);

import 'dart:convert';

NewFreshReleaseBooksModel newfreshReleaseBookModelFromJson(String str) =>
    NewFreshReleaseBooksModel.fromJson(json.decode(str));

String newfreshReleaseBookModelToJson(NewFreshReleaseBooksModel data) =>
    json.encode(data.toJson());

class NewFreshReleaseBooksModel {
  final int totalItem;
  final dynamic nextPage;
  final dynamic previousPage;
  final List<NewFreshReleaseBookList> newfreshRelease;

  NewFreshReleaseBooksModel({
    required this.totalItem,
    required this.nextPage,
    required this.previousPage,
    required this.newfreshRelease,
  });

  factory NewFreshReleaseBooksModel.fromJson(Map<String, dynamic> json) =>
      NewFreshReleaseBooksModel(
        totalItem: json["count"],
        nextPage: json["next"],
        previousPage: json["previous"],
        newfreshRelease: List<NewFreshReleaseBookList>.from(
            json["results"].map((x) => NewFreshReleaseBookList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": totalItem,
        "next": nextPage,
        "previous": previousPage,
        "results": List<dynamic>.from(newfreshRelease.map((x) => x.toJson())),
      };
}

class NewFreshReleaseBookList {
  final int bookId;
  final String bookName;
  final String coverImage;
  final int publisherId;
  final int categoryId;
  final int courseId;
  final int authorId;

  NewFreshReleaseBookList({
    required this.bookId,
    required this.bookName,
    required this.coverImage,
    required this.publisherId,
    required this.categoryId,
    required this.courseId,
    required this.authorId,
  });

  factory NewFreshReleaseBookList.fromJson(Map<String, dynamic> json) =>
      NewFreshReleaseBookList(
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
