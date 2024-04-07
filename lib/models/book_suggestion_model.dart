// To parse this JSON data, do
//
//     final bookSuggestionRelatedToBookId = bookSuggestionRelatedToBookIdFromJson(jsonString);

import 'dart:convert';

BookSuggestionModel bookSuggestionRelatedToBookIdFromJson(String str) =>
    BookSuggestionModel.fromJson(json.decode(str));

String bookSuggestionRelatedToBookIdToJson(BookSuggestionModel data) =>
    json.encode(data.toJson());

class BookSuggestionModel {
  final List<BookSuggestionList> suggestionData;

  BookSuggestionModel({
    required this.suggestionData,
  });

  factory BookSuggestionModel.fromJson(Map<String, dynamic> json) =>
      BookSuggestionModel(
        suggestionData: List<BookSuggestionList>.from(
            json["data"].map((x) => BookSuggestionList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(suggestionData.map((x) => x.toJson())),
      };
}

class BookSuggestionList {
  final int bookId;
  final String bookName;
  final String coverImage;

  BookSuggestionList({
    required this.bookId,
    required this.bookName,
    required this.coverImage,
  });

  factory BookSuggestionList.fromJson(Map<String, dynamic> json) =>
      BookSuggestionList(
        bookId: json["id"],
        bookName: json["name"],
        coverImage: json["cover_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": bookId,
        "name": bookName,
        "cover_image": coverImage,
      };
}
