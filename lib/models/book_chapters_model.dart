import 'dart:convert';

BookChaptersModel bookChaptersModelFromJson(String str) =>
    BookChaptersModel.fromJson(json.decode(str));

String bookChaptersModelToJson(BookChaptersModel data) =>
    json.encode(data.toJson());

class BookChaptersModel {
  final List<BookChaptersList> chaptersData;
  final int chaptersCount;
  final String remainingBookChaptersText;
  final int isReadable;

  BookChaptersModel({
    required this.chaptersData,
    required this.chaptersCount,
    required this.remainingBookChaptersText,
    required this.isReadable,
  });

  factory BookChaptersModel.fromJson(Map<String, dynamic> json) =>
      BookChaptersModel(
        chaptersData: List<BookChaptersList>.from(
            json["data"].map((x) => BookChaptersList.fromJson(x))),
        chaptersCount: json["chapters_count"],
        remainingBookChaptersText: json["remaining_book_chapters_text"],
        isReadable: json["is_readable"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(chaptersData.map((x) => x.toJson())),
        "chapters_count": chaptersCount,
        "remaining_book_chapters_text": remainingBookChaptersText,
        "is_readable": isReadable,
      };
}

class BookChaptersList {
  final int id;
  final int bookId;
  final int chapterIndex;
  final String chapterName;
  final int pages;
  final int startPage;
  final int endPage;
  final String chapterUrl;
  final int readCompletionsPercentage;
  final int readPages;
  final int isDownloaded;

  BookChaptersList({
    required this.id,
    required this.bookId,
    required this.chapterIndex,
    required this.chapterName,
    required this.pages,
    required this.startPage,
    required this.endPage,
    required this.chapterUrl,
    required this.readCompletionsPercentage,
    required this.readPages,
    required this.isDownloaded,
  });

  factory BookChaptersList.fromJson(Map<String, dynamic> json) =>
      BookChaptersList(
        id: json["id"],
        bookId: json["book_id"],
        chapterIndex: json["chapter_index"],
        chapterName: json["chapter_name"],
        pages: json["pages"],
        startPage: json["start_page_number"],
        endPage: json["end_page_number"],
        chapterUrl: json["chapter_url"],
        readCompletionsPercentage: json["read_completions_percentage"],
        readPages: json["read_pages"],
        isDownloaded: json["is_downloaded"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "book_id": bookId,
        "chapter_index": chapterIndex,
        "chapter_name": chapterName,
        "pages": pages,
        "start_page_number": startPage,
        "end_page_number": endPage,
        "chapter_url": chapterUrl,
        "read_completions_percentage": readCompletionsPercentage,
        "read_pages": readPages,
        "is_downloaded": isDownloaded,
      };
}
