class ShelfBook {
  final int id;
  final int bookId;
  final int userId;
  final int? shelfCategoryId; // Nullable since "shelf_category_id" can be null
  final String name;
  final String coverImage;
  final String fileUrl; // Added fileUrl field
  final int stage;
  final int chapters;
  final int newChapters;
  final int isDownloaded;
  final int readChapters;
  final int chapterCompletionsPercentage;
  final List<int> mappedUserCategoryIds;

  ShelfBook({
    required this.id,
    required this.bookId,
    required this.userId,
    this.shelfCategoryId, // Made nullable
    required this.name,
    required this.coverImage,
    required this.fileUrl, // Add fileUrl to constructor
    required this.stage,
    required this.chapters,
    required this.newChapters,
    required this.isDownloaded,
    required this.readChapters,
    required this.chapterCompletionsPercentage,
    required this.mappedUserCategoryIds,
  });

  factory ShelfBook.fromJson(Map<String, dynamic> json) {
    return ShelfBook(
      id: int.tryParse(json['id'].toString()) ?? 0,
      bookId: int.tryParse(json['book_id'].toString()) ?? 0,
      userId: int.tryParse(json['user_id'].toString()) ?? 0,
      shelfCategoryId: json['shelf_category_id'] != null
          ? int.tryParse(json['shelf_category_id'].toString())
          : null,
      name: json['name'],
      coverImage: json['cover_image'],
      fileUrl: json['file_url'], // Parse fileUrl from JSON
      stage: int.tryParse(json['stage'].toString()) ?? 0,
      chapters: int.tryParse(json['chapters'].toString()) ?? 0,
      newChapters: int.tryParse(json['new_chapters'].toString()) ?? 0,
      isDownloaded: int.tryParse(json['is_downloaded'].toString()) ?? 0,
      readChapters: int.tryParse(json['read_chapters'].toString()) ?? 0,
      chapterCompletionsPercentage:
          int.tryParse(json['chapter_completions_percentage'].toString()) ?? 0,
      mappedUserCategoryIds: List<int>.from(json['mapped_user_category_ids']
          .map((x) => int.tryParse(x.toString()) ?? 0)),
    );
  }
}
