// To parse this JSON data, do
//
//     final bookCategoriesModel = bookCategoriesModelFromJson(jsonString);

import 'dart:convert';

List<BookCategoryModel> bookCategoriesModelFromJson(String str) =>
    List<BookCategoryModel>.from(
        json.decode(str).map((x) => BookCategoryModel.fromJson(x)));

String bookCategoriesModelToJson(List<BookCategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookCategoryModel {
  final int categoryId;
  final String categoryName;
  final String categoryImg;

  BookCategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImg,
  });

  factory BookCategoryModel.fromJson(Map<String, dynamic> json) =>
      BookCategoryModel(
        categoryId: json["id"],
        categoryName: json["name"],
        categoryImg: json["category_icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": categoryId,
        "name": categoryName,
        "category_icon": categoryImg,
      };
}
