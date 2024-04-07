// To parse this JSON data, do
//
//     final bookListByStaffIdModel = bookListByStaffIdModelFromJson(jsonString);

import 'dart:convert';

BookListByStaffIdModel bookListByStaffIdModelFromJson(String str) =>
    BookListByStaffIdModel.fromJson(json.decode(str));

String bookListByStaffIdModelToJson(BookListByStaffIdModel data) =>
    json.encode(data.toJson());

class BookListByStaffIdModel {
  final int itemCount;
  final dynamic nextPage;
  final dynamic previousPage;
  final List<BookListByStaffId> results;

  BookListByStaffIdModel({
    required this.itemCount,
    required this.nextPage,
    required this.previousPage,
    required this.results,
  });

  factory BookListByStaffIdModel.fromJson(Map<String, dynamic> json) =>
      BookListByStaffIdModel(
        itemCount: json["count"],
        nextPage: json["next"],
        previousPage: json["previous"],
        results: List<BookListByStaffId>.from(
            json["results"].map((x) => BookListByStaffId.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": itemCount,
        "next": nextPage,
        "previous": previousPage,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class BookListByStaffId {
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

  BookListByStaffId({
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
  });

  factory BookListByStaffId.fromJson(Map<String, dynamic> json) =>
      BookListByStaffId(
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
      };
}
