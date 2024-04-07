import 'dart:convert';

// Function to parse a JSON string and return a list of Post objects
List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

// Function to take a list of Post objects and return a JSON string
String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  final int id;
  final int userId;
  final String title;
  final String shortTitle;
  final String coverImage;
  final String fileUrl;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.shortTitle,
    required this.coverImage,
    required this.fileUrl,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: int.parse(json['id'].toString()),
        userId: int.parse(json['user_id'].toString()),
        title: json['title'],
        shortTitle: json['short_title'],
        coverImage: json['cover_image'],
        fileUrl: json['file_url'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'title': title,
        'short_title': shortTitle,
        'cover_image': coverImage,
        'file_url': fileUrl,
      };
}
