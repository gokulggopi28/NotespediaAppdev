int safeParse(String? value, {int defaultValue = 0}) {
  return int.tryParse(value ?? '') ?? defaultValue;
}

class DownloadData {
  DownloadData({
    required this.id,
    required this.userId,
    required this.bookId,
    required this.name,
    required this.coverImage,
    required this.authorName,
    required this.stage,
    required this.fileurl,
    required this.newChapters,
    required this.isDownloaded,
    required this.mappedUserCategoryIds,
  });

  final int id;
  final int userId;
  final int bookId;
  final String name;
  final String coverImage;
  final String authorName;
  final String fileurl;
  final int stage;
  final int newChapters;
  final int isDownloaded;
  final List<dynamic> mappedUserCategoryIds;

  factory DownloadData.fromJson(Map<String, dynamic> json) => DownloadData(
        id: safeParse(json["id"].toString()),
        userId: safeParse(json["user_id"].toString()),
        bookId: safeParse(json["book_id"].toString()),
        name: json["name"],
        coverImage: json["cover_image"],
        authorName: json["author_name"],
        fileurl: json["file_url"].toString(),
        stage: safeParse(json["stage"].toString()),
        newChapters: safeParse(json["new_chapters"].toString()),
        isDownloaded: safeParse(json["is_downloaded"].toString()),
        mappedUserCategoryIds:
            List<dynamic>.from(json["mapped_user_category_ids"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "book_id": bookId,
        "name": name,
        "cover_image": coverImage,
        "author_name": authorName,
        "file_url": fileurl,
        "stage": stage,
        "new_chapters": newChapters,
        "is_downloaded": isDownloaded,
        "mapped_user_category_ids":
            List<dynamic>.from(mappedUserCategoryIds.map((x) => x)),
      };
}
