// To parse this JSON data, do
//
//     final bookDetailsModel = bookDetailsModelFromJson(jsonString);

import 'dart:convert';

BookDetailModel bookDetailsModelFromJson(String str) =>
    BookDetailModel.fromJson(json.decode(str));

String bookDetailsModelToJson(BookDetailModel data) =>
    json.encode(data.toJson());

class BookDetailModel {
  final BookDetailData bookDetailData;

  BookDetailModel({
    required this.bookDetailData,
  });

  factory BookDetailModel.fromJson(Map<String, dynamic> json) =>
      BookDetailModel(
        bookDetailData: BookDetailData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": bookDetailData.toJson(),
      };
}

class BookDetailData {
  final int bookId;
  final String bookName;
  final String bookCoverImage;
  final String bookDescription;
  final String authorName;
  final String authorImage;
  final int publisherId;
  final int categoryId;
  final int courseId;
  final int authorId;
  final int totalChapters;
  final int totalPages;
  final int bookReadCount;
  final String bookRating;
  final int status;
  final int newChapters;
  final String fileurl;
  final String categoryName;
  final String courseName;
  final int hasHardCopy;
  final int hasSoftCopy;
  final double hardCopyOldPrice;
  final double hardCopyNewPrice;
  final double softCopyOldPrice;
  final double softCopyNewPrice;
  final List<Tag> tags;

  BookDetailData({
    required this.bookId,
    required this.bookName,
    required this.bookCoverImage,
    required this.bookDescription,
    required this.authorName,
    required this.authorImage,
    required this.publisherId,
    required this.categoryId,
    required this.courseId,
    required this.authorId,
    required this.totalChapters,
    required this.totalPages,
    required this.bookReadCount,
    required this.bookRating,
    required this.hasHardCopy,
    required this.hasSoftCopy,
    required this.categoryName,
    required this.courseName,
    required this.status,
    required this.newChapters,
    required this.fileurl,
    required this.hardCopyOldPrice,
    required this.hardCopyNewPrice,
    required this.softCopyOldPrice,
    required this.softCopyNewPrice,
    required this.tags,
  });

  factory BookDetailData.fromJson(Map<String, dynamic> json) => BookDetailData(
        bookId: json["id"],
        bookName: json["name"],
        bookCoverImage: json["cover_image"] ?? "",
        bookDescription: json["description"] ?? "",
        authorName: json["author_name"] ?? "",
        authorImage: json["author_image"] ?? "",
        categoryId: json["category_id"],
        publisherId: json["publisher_id"],
        courseId: json["course_id"],
        authorId: json["author_id"],
        totalChapters: json["chapters"],
        totalPages: json["pages"],
        bookReadCount: json["reads"],
        hasHardCopy: json["has_hard_copy"],
        hasSoftCopy: json["has_soft_copy"],
        categoryName: json["category_name"] ?? "",
        courseName: json["course_name"] ?? "",
        bookRating: json["rating"] ?? "",
        status: json["stage"],
        newChapters: json["new_chapters"],
        fileurl: json["file_url"] ?? "",
        hardCopyOldPrice: json["hard_copy_old_price"]?.toDouble() ?? 0.0,
        hardCopyNewPrice: json["hard_copy_new_price"]?.toDouble() ?? 0.0,
        softCopyOldPrice: json["soft_copy_old_price"]?.toDouble() ?? 0.0,
        softCopyNewPrice: json["soft_copy_new_price"]?.toDouble() ?? 0.0,
        tags: List<Tag>.from(json["tags"]?.map((x) => Tag.fromJson(x)) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "id": bookId,
        "name": bookName,
        "cover_image": bookCoverImage,
        "description": bookDescription,
        "author_name": authorName,
        "author_image": authorImage,
        "publisher_id": publisherId,
        "category_id": categoryId,
        "course_id": courseId,
        "author_id": authorId,
        "reads": bookReadCount,
        "chapters": totalChapters,
        "pages": totalPages,
        "rating": bookRating,
        "stage": status,
        "file_url": fileurl,
        "has_hard_copy": hasHardCopy,
        "has_soft_copy": hasSoftCopy,
        "hard_copy_old_price": hardCopyOldPrice,
        "hard_copy_new_price": hardCopyNewPrice,
        "soft_copy_old_price": softCopyOldPrice,
        "soft_copy_new_price": softCopyNewPrice,
        "new_chapters": newChapters,
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
      };
}

class Tag {
  final int id;
  final int tagId;
  final int bookId;
  final String tagName;

  Tag({
    required this.id,
    required this.tagId,
    required this.bookId,
    required this.tagName,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"],
        bookId: json["book_id"],
        tagId: json["tag_id"],
        tagName: json["tag_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "book_id": bookId,
        "tag_id": tagId,
        "tag_name": tagName,
      };
}
