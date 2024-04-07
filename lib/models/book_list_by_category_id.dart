// To parse this JSON data, do
//
//     final categoryBasedBookModel = categoryBasedBookModelFromJson(jsonString);

import 'dart:convert';

BookListByCategoryIdModel categoryBasedBookModelFromJson(String str) =>
    BookListByCategoryIdModel.fromJson(json.decode(str));

String categoryBasedBookModelToJson(BookListByCategoryIdModel data) =>
    json.encode(data.toJson());

class BookListByCategoryIdModel {
  final int itemCount;
  final dynamic nextPage;
  final dynamic previousPage;
  final List<BookListByCategoryId> results;

  BookListByCategoryIdModel({
    required this.itemCount,
    required this.nextPage,
    required this.previousPage,
    required this.results,
  });

  factory BookListByCategoryIdModel.fromJson(Map<String, dynamic> json) =>
      BookListByCategoryIdModel(
        itemCount: json["count"],
        nextPage: json["next"],
        previousPage: json["previous"],
        results: List<BookListByCategoryId>.from(
            json["results"].map((x) => BookListByCategoryId.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": itemCount,
        "next": nextPage,
        "previous": previousPage,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class BookListByCategoryId {
  final int bookId;
  final String bookName;
  final String coverImage;
  final int publisherId;
  final int chapters;
  final int pages;
  final int categoryId;
  final int courseId;
  final String description;
  final int hasHardCopy;
  final int hasSoftCopy;
  final int authorId;
  final int reads;
  final String rating;
  final int stage;
  final int newChapters;

  BookListByCategoryId({
    required this.bookId,
    required this.bookName,
    required this.coverImage,
    required this.publisherId,
    required this.chapters,
    required this.pages,
    required this.categoryId,
    required this.courseId,
    required this.description,
    required this.hasHardCopy,
    required this.hasSoftCopy,
    required this.authorId,
    required this.reads,
    required this.rating,
    required this.stage,
    required this.newChapters,
  });

  factory BookListByCategoryId.fromJson(Map<String, dynamic> json) =>
      BookListByCategoryId(
        bookId: json["id"],
        bookName: json["name"],
        coverImage: json["cover_image"],
        publisherId: json["publisher_id"],
        chapters: json["chapters"],
        pages: json["pages"],
        categoryId: json["category_id"],
        courseId: json["course_id"],
        description: json["description"],
        hasHardCopy: json["has_hard_copy"],
        hasSoftCopy: json["has_soft_copy"],
        authorId: json["author_id"],
        reads: json["reads"],
        rating: json["rating"],
        stage: json["stage"],
        newChapters: json["new_chapters"],
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
        "has_hard_copy": hasHardCopy,
        "has_soft_copy": hasSoftCopy,
        "author_id": authorId,
        "reads": reads,
        "rating": rating,
        "stage": stage,
        "new_chapters": newChapters,
      };
}
