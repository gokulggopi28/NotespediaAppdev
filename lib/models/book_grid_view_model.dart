class BookChapterGridViewModel {
  final List<Chapter> data;
  final int chaptersCount;
  final String remainingBookChaptersText;
  final int isReadable;

  BookChapterGridViewModel({
    required this.data,
    required this.chaptersCount,
    required this.remainingBookChaptersText,
    required this.isReadable,
  });

  factory BookChapterGridViewModel.fromJson(Map<String, dynamic> json) =>
      BookChapterGridViewModel(
        data: List<Chapter>.from(json["data"].map((x) => Chapter.fromJson(x))),
        chaptersCount: json["chapters_count"],
        remainingBookChaptersText: json["remaining_book_chapters_text"],
        isReadable: json["is_readable"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "chapters_count": chaptersCount,
        "remaining_book_chapters_text": remainingBookChaptersText,
        "is_readable": isReadable,
      };
}

class Chapter {
  final int id;
  final int bookId;
  final int chapterIndex;
  final String chapterName;
  final int pages;
  final int startPageNumber;
  final int endPageNumber;
  final String chapterUrl;
  final int readCompletionsPercentage;
  final int readPages;
  final int newUpdates;
  final int isNew;
  final int isEdited;
  final int isDownloaded;

  Chapter({
    required this.id,
    required this.bookId,
    required this.chapterIndex,
    required this.chapterName,
    required this.pages,
    required this.startPageNumber,
    required this.endPageNumber,
    required this.chapterUrl,
    required this.readCompletionsPercentage,
    required this.readPages,
    required this.newUpdates,
    required this.isNew,
    required this.isEdited,
    required this.isDownloaded,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        id: json["id"],
        bookId: json["book_id"],
        chapterIndex: json["chapter_index"],
        chapterName: json["chapter_name"],
        pages: json["pages"],
        startPageNumber: json["start_page_number"],
        endPageNumber: json["end_page_number"],
        chapterUrl: json["chapter_url"],
        readCompletionsPercentage: json["read_completions_percentage"] ?? 0,
        readPages: json["read_pages"] ?? 0,
        newUpdates: json["new_updates"] ?? 0,
        isNew: json["new"] ?? 0,
        isEdited: json["edited"] ?? 0,
        isDownloaded: json["is_downloaded"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "book_id": bookId,
        "chapter_index": chapterIndex,
        "chapter_name": chapterName,
        "pages": pages,
        "start_page_number": startPageNumber,
        "end_page_number": endPageNumber,
        "chapter_url": chapterUrl,
        "read_completions_percentage": readCompletionsPercentage,
        "read_pages": readPages,
        "new_updates": newUpdates,
        "new": isNew,
        "edited": isEdited,
        "is_downloaded": isDownloaded,
      };
}
