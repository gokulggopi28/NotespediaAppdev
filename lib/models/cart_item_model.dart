// To parse this JSON data, do
//
//     final cartItemModel = cartItemModelFromJson(jsonString);

import 'dart:convert';

CartItemModel cartItemModelFromJson(String str) =>
    CartItemModel.fromJson(json.decode(str));

String cartItemModelToJson(CartItemModel data) => json.encode(data.toJson());

class CartItemModel {
  final List<CartItemList> cartData;

  CartItemModel({
    required this.cartData,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        cartData: List<CartItemList>.from(
            json["data"].map((x) => CartItemList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(cartData.map((x) => x.toJson())),
      };
}

class CartItemList {
  final int itemId;
  final int cartId;
  final int bookId;
  final int quantity;
  // final String bookType;
  final String bookName;
  final String bookCoverImage;
  final double bookPrice;
  final String authorName;
  final List<String> tags;

  CartItemList({
    required this.itemId,
    required this.cartId,
    required this.bookId,
    required this.quantity,
    // required this.bookType,
    required this.bookName,
    required this.bookCoverImage,
    required this.bookPrice,
    required this.authorName,
    required this.tags,
  });

  factory CartItemList.fromJson(Map<String, dynamic> json) => CartItemList(
        itemId: json["id"],
        cartId: json["cart_id"],
        bookId: json["book_id"],
        quantity: json["quantity"],
        //  bookType: json["book_type"],
        bookName: json["book_name"],
        bookCoverImage: json["book_cover_image"],
        bookPrice:
            json["book_price"] == null ? 0.0 : json["book_price"].toDouble(),
        authorName: json["author_name"],
        tags: List<String>.from(json["tags"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": itemId,
        "cart_id": cartId,
        "book_id": bookId,
        "quantity": quantity,
        // "book_type": bookType,
        "book_name": bookName,
        "book_cover_image": bookCoverImage,
        "book_price": bookPrice,
        "author_name": authorName,
        "tags": List<dynamic>.from(tags.map((x) => x)),
      };
}
