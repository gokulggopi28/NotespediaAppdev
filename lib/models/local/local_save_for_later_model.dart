import 'dart:convert';

SaveForLaterBook saveForLaterBookFromJson(String str) =>
    SaveForLaterBook.fromJson(json.decode(str));

String saveForLaterBookToJson(SaveForLaterBook data) =>
    json.encode(data.toJson());

class SaveForLaterBook {
  final int id;
  final int bookId;
  final int userId;
  final String name;
  final String coverImage;
  final int stage;
  final String authorName;
  final int isDownloaded;

  SaveForLaterBook({
    required this.id,
    required this.bookId,
    required this.userId,
    required this.name,
    required this.coverImage,
    required this.stage,
    required this.authorName,
    required this.isDownloaded,
  });

  factory SaveForLaterBook.fromJson(Map<String, dynamic> json) =>
      SaveForLaterBook(
        id: int.tryParse(json['id'].toString()) ?? 0,
        bookId: int.tryParse(json['book_id'].toString()) ?? 0,
        userId: int.tryParse(json['user_id'].toString()) ?? 0,
        name: json['name'],
        coverImage: json['cover_image'],
        stage: int.tryParse(json['stage'].toString()) ?? 0,
        authorName: json['author_name'],
        isDownloaded: int.tryParse(json['is_downloaded'].toString()) ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'book_id': bookId,
        'user_id': userId,
        'name': name,
        'cover_image': coverImage,
        'stage': stage,
        'author_name': authorName,
        'is_downloaded': isDownloaded,
      };
}
