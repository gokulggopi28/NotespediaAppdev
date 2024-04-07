// To parse this JSON data, do
//
//     final topReadBooksModel = topReadBooksModelFromJson(jsonString);

import 'dart:convert';

TopReadBooksModel topReadBooksModelFromJson(String str) =>
    TopReadBooksModel.fromJson(json.decode(str));

String topReadBooksModelToJson(TopReadBooksModel data) =>
    json.encode(data.toJson());

class TopReadBooksModel {
  final int totalItem;
  final dynamic nextPage;
  final dynamic previousPage;
  final List<TopReadBookList> topRead;

  TopReadBooksModel({
    required this.totalItem,
    required this.nextPage,
    required this.previousPage,
    required this.topRead,
  });

  factory TopReadBooksModel.fromJson(Map<String, dynamic> json) =>
      TopReadBooksModel(
        totalItem: json["count"],
        nextPage: json["next"],
        previousPage: json["previous"],
        topRead: List<TopReadBookList>.from(
            json["results"].map((x) => TopReadBookList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": totalItem,
        "next": nextPage,
        "previous": previousPage,
        "results": List<dynamic>.from(topRead.map((x) => x.toJson())),
      };
}

class TopReadBookList {
  final int bookId;
  final String bookName;
  final String coverImage;
  final String description;
  final int publisherId;
  final int categoryId;
  final int courseId;
  final int authorId;
  final int chapters;
  final int pages;
  final int readsCount;

  TopReadBookList({
    required this.bookId,
    required this.bookName,
    required this.coverImage,
    required this.publisherId,
    required this.chapters,
    required this.pages,
    required this.readsCount,
    required this.categoryId,
    required this.courseId,
    required this.description,
    required this.authorId,
  });

  factory TopReadBookList.fromJson(Map<String, dynamic> json) =>
      TopReadBookList(
        bookId: json["id"],
        bookName: json["name"],
        coverImage: json["cover_image"],
        publisherId: json["publisher_id"],
        chapters: json["chapters"],
        pages: json["pages"],
        categoryId: json["category_id"],
        courseId: json["course_id"],
        description: json["description"],
        authorId: json["author_id"],
        readsCount: json["reads"],
      );

  Map<String, dynamic> toJson() => {
        "id": bookId,
        "name": bookName,
        "cover_image": coverImage,
        "publisher_id": publisherId,
        "chapters": chapters,
        "pages": pages,
        "category_id": categoryId,
        "course_id": courseId,
        "description": description,
        "author_id": authorId,
        "reads": readsCount,
      };
}
