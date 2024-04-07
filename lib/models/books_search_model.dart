// To parse this JSON data, do
//
//     final bookSearchModel = bookSearchModelFromJson(jsonString);

import 'dart:convert';

BooksSearchModel bookSearchModelFromJson(String str) =>
    BooksSearchModel.fromJson(json.decode(str));

String bookSearchModelToJson(BooksSearchModel data) =>
    json.encode(data.toJson());

class BooksSearchModel {
  final BooksSearchData searchData;

  BooksSearchModel({
    required this.searchData,
  });

  factory BooksSearchModel.fromJson(Map<String, dynamic> json) =>
      BooksSearchModel(
        searchData: BooksSearchData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": searchData.toJson(),
      };
}

class BooksSearchData {
  final List<SearchTopCategoriesList> searchTopCategoriesList;
  final List<SearchBooksList> searchBooksList;
  final List<SearchTopPublishersList> searchTopPublishersList;

  BooksSearchData({
    required this.searchTopCategoriesList,
    required this.searchBooksList,
    required this.searchTopPublishersList,
  });

  factory BooksSearchData.fromJson(Map<String, dynamic> json) =>
      BooksSearchData(
        searchTopCategoriesList: List<SearchTopCategoriesList>.from(
            json["top_categories"]
                .map((x) => SearchTopCategoriesList.fromJson(x))),
        searchBooksList: List<SearchBooksList>.from(
            json["books"].map((x) => SearchBooksList.fromJson(x))),
        searchTopPublishersList: List<SearchTopPublishersList>.from(
            json["top_publishers"]
                .map((x) => SearchTopPublishersList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "top_categories":
            List<dynamic>.from(searchTopCategoriesList.map((x) => x.toJson())),
        "books": List<dynamic>.from(searchBooksList.map((x) => x.toJson())),
        "top_publishers":
            List<dynamic>.from(searchTopPublishersList.map((x) => x.toJson())),
      };
}

class SearchBooksList {
  final int bookId;
  final String bookName;
  final String bookCoverImage;
  final int publisherId;
  final int categoryId;
  final int courseId;
  final int authorId;

  SearchBooksList({
    required this.bookId,
    required this.bookName,
    required this.bookCoverImage,
    required this.publisherId,
    required this.categoryId,
    required this.courseId,
    required this.authorId,
  });

  factory SearchBooksList.fromJson(Map<String, dynamic> json) =>
      SearchBooksList(
        bookId: json["id"],
        bookName: json["name"],
        bookCoverImage: json["cover_image"],
        publisherId: json["publisher_id"],
        categoryId: json["category_id"],
        courseId: json["course_id"],
        authorId: json["author_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": bookId,
        "name": bookName,
        "cover_image": bookCoverImage,
        "publisher_id": publisherId,
        "category_id": categoryId,
        "course_id": courseId,
        "author_id": authorId,
      };
}

class SearchTopCategoriesList {
  final int id;
  final String name;
  final String categoryIcon;

  SearchTopCategoriesList({
    required this.id,
    required this.name,
    required this.categoryIcon,
  });

  factory SearchTopCategoriesList.fromJson(Map<String, dynamic> json) =>
      SearchTopCategoriesList(
        id: json["id"],
        name: json["name"],
        categoryIcon: json["category_icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category_icon": categoryIcon,
      };
}

class SearchTopPublishersList {
  final int id;
  final String mobileNumber;
  final String profileImage;
  final int userId;
  final String name;
  final String email;

  SearchTopPublishersList({
    required this.id,
    required this.mobileNumber,
    required this.profileImage,
    required this.userId,
    required this.name,
    required this.email,
  });

  factory SearchTopPublishersList.fromJson(Map<String, dynamic> json) =>
      SearchTopPublishersList(
        id: json["id"],
        mobileNumber: json["mobile_number"],
        profileImage: json["profile_image"],
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mobile_number": mobileNumber,
        "profile_image": profileImage,
        "user_id": userId,
        "name": name,
        "email": email,
      };
}
